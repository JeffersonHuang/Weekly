import 'package:flutter/material.dart';

import 'widgets/categories_list_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.index});

  final int index;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
      body: CategoriesListWidget(index: widget.index),
    );
  }
}
