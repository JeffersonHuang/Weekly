import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:weekly/feature/article/bloc/article_bloc.dart';

class Article extends StatefulWidget {
  final String link;
  final String title;

  const Article({
    super.key,
    required this.title,
    required this.link,
  });

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArticleBloc()..add(ArticleFetchEvent(widget.link)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.title),
        ),
        body: Center(
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              return Markdown(
                data: state.article,
                onTapLink: (text, href, title) => context
                    .read<ArticleBloc>()
                    .add(ArticleOpenBrowserEvent(text, href, title)),
              );
            },
          ),
        ),
      ),
    );
  }
}
