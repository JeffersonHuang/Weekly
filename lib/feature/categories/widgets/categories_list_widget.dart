import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly/feature/article/article.dart';
import 'package:weekly/feature/home/bloc/categories_bloc.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, Categories>(
      builder: (BuildContext context, state) {
        return Center(
          child: state.books[index].categories.isEmpty
              ? const CircularProgressIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  itemCount: state.books[index].categories.length,
                  itemBuilder: (context, idx) {
                    return Card(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                              '${state.books[index].categories[idx].year}/${state.books[index].categories[idx].month}'),
                          children: [
                            for (var item
                                in state.books[index].categories[idx].array)
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
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
