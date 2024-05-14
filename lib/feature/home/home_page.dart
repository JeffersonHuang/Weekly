import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly/data/models/weekly_data.dart';
import 'package:weekly/feature/detail/bloc/CounterCubit.dart';
import 'package:weekly/feature/detail/detail.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  List<WeeklyData> _list = [];

  @override
  void initState() {
    super.initState();
    // getTextData(ApiPath.catalogue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (BuildContext context, state) {
            return Text(state.toString());
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: _list.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text('${_list[index].year}/${_list[index].month}'),
                    children: [
                      for (var item in _list[index].array)
                        GestureDetector(
                          child: ListTile(
                            title: Text(item.title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                      title: item.title, link: item.link),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
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
    _list = (json.decode(jsonString) as List)
        .map((item) => WeeklyData.fromJson(item))
        .toList();
    setState(() {});
    return jsonString;
  }
}
