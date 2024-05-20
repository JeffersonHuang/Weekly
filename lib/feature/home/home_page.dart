import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/categories_bloc.dart';
import 'widgets/book_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child: BookWidget(),
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