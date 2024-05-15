import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weekly/data/models/weekly_data.dart';
import 'package:weekly/data/repo/repo.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, Categories> {
  List<WeeklyData> _list = [];

  CategoriesBloc() : super(Categories([])) {
    on<CategoriesFetchEvent>((event, emit) async {
      final categories = await weeklyRepo.getAllCategories();
      log(categories);
      final res = getMarkdownData(categories);
      _list = (json.decode(res) as List)
          .map((item) => WeeklyData.fromJson(item))
          .toList();
      emit(Categories(_list));
    });
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

  String getMarkdownData(String rawData) {
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
    log(jsonString);
    return jsonString;
  }
}
