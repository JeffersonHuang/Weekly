import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly/feature/article/article.dart';
import 'package:weekly/feature/home/bloc/categories_bloc.dart';

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
    // getTextData(ApiPath.catalogue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<CategoriesBloc, Categories>(
        builder: (BuildContext context, state) {
          return Center(
            child: state.categories.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                            '${state.categories[index].year}/${state.categories[index].month}'),
                        children: [
                          for (var item in state.categories[index].array)
                            GestureDetector(
                              child: ListTile(
                                title: Text(item.title),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Article(
                                          title: item.title, link: item.link),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<CategoriesBloc>().add(const CategoriesFetchEvent()),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
