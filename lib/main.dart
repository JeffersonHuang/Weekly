import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weekly/constants/url.dart';
import 'package:weekly/pages/detail.dart';
import 'dart:convert';

import 'models/weekly_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weekly-科技爱好者周刊'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dio = Dio();
  List<WeeklyData> _list = [];

  @override
  void initState() {
    super.initState();
    getTextData(Url.catalogue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        onPressed: () {
          getTextData(Url.catalogue);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Future<String> getTextData(String url) async {
    var response = await dio.get(url);
    getMarkdownData(getMetaData(response.data.toString()));
    return response.data;
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
    _list = (json.decode(jsonString) as List)
        .map((item) => WeeklyData.fromJson(item))
        .toList();
    log(_list.toString());
    setState(() {});
    return jsonString;
  }
}
