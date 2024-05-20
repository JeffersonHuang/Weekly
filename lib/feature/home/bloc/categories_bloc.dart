import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weekly/constants/api_path.dart';
import 'package:weekly/data/models/book_item.dart';
import 'package:weekly/data/models/weekly_data.dart';
import 'package:weekly/data/repo/repo.dart';
import 'package:weekly/data/service/service.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, Categories> {
  List<WeeklyData> _list = [];

  CategoriesBloc() : super(Categories([], true)) {
    on<CategoriesFetchEvent>((event, emit) async {
      final file = await weeklyRepo.getLocalFile();
      if (file.isNotEmpty) {
        _list = _parseJsonToList(file);
        emit(Categories(_list, false));
      }
      await fetchAndCacheCategories();
      emit(Categories(_list, false));
    });
  }

  Future<void> fetchAndCacheCategories() async {
    final categories = await weeklyRepo.getAllCategories();
    if (categories.statusCode == 200) {
      final res = _getMarkdownData(categories.data);
      _list = _parseJsonToList(res);
      storageService.cacheWeeklyData(cacheFileName: ApiPath.readme, data: res);
    }
  }

  List<WeeklyData> _parseJsonToList(String jsonData) {
    return (json.decode(jsonData) as List)
        .map((item) => WeeklyData.fromJson(item))
        .toList();
  }

  String getMetaData(String rawData) {
    RegExp regExp = RegExp(r'## 20\d{2}');
    Iterable<Match> matches = regExp.allMatches(rawData);
    String targetSection = "";
    if (matches.isNotEmpty) {
      int start = matches.first.start;
      targetSection = rawData.substring(start);
    }
    return targetSection;
  }

  String _getMarkdownData(String rawData) {
    List<Map<String, dynamic>> issues = [];
    List<String> lines = rawData.split('\n');

    String? currentYear;
    String? currentMonth;
    List<Map<String, dynamic>> currentArray = [];
    for (var line in lines) {
      if (line.startsWith('##')) {
        currentYear = line.substring(2).trim();
        currentArray = [];
      } else if (line.startsWith('**')) {
        currentMonth = line.substring(2, line.length - 2);
        currentArray = [];
      } else if (line.isNotEmpty && line.startsWith('-')) {
        RegExp regExp = RegExp(r'第 (\d+) 期：\[([^\]]+)\]\(([^)]+)\)');
        Match? match = regExp.firstMatch(line);
        if (match != null) {
          currentArray.add({
            'number': int.parse(match.group(1)!),
            'title': match.group(2)!,
            'link': match.group(3)!,
          });
        }
      }

      if (currentArray.isNotEmpty && line.isEmpty) {
        issues.add({
          'year': currentYear,
          'month': currentMonth,
          'array': currentArray
        });
      }
    }

    String jsonString = jsonEncode(issues);
    return jsonString;
  }
}
