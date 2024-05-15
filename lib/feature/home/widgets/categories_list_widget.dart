import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly/feature/article/article.dart';
import 'package:weekly/feature/home/bloc/categories_bloc.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, Categories>(
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
                  },
                ),
        );
      },
    );
  }
}
