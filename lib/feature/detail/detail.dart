import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:weekly/constants/api_path.dart';

class Detail extends StatefulWidget {
  final String link;
  final String title;

  const Detail({
    super.key,
    required this.title,
    required this.link,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: getTextData(ApiPath.prefix + widget.link),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Markdown(data: snapshot.data!);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<String> getTextData(String url) async {
    var response = await dio.get(url);
    return response.data;
  }
}
