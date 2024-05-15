import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly/feature/article/article.dart';
import 'package:weekly/feature/home/bloc/categories_bloc.dart';

import 'widgets/categories_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const CategoriesListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<CategoriesBloc>().add(const CategoriesFetchEvent()),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
