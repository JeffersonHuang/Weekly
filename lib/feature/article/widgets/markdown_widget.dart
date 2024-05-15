import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:weekly/feature/article/bloc/article_bloc.dart';

class ArticleMarkdownWidget extends StatelessWidget {
  const ArticleMarkdownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        return Markdown(
          data: state.article,
          onTapLink: (text, href, title) => context
              .read<ArticleBloc>()
              .add(ArticleOpenBrowserEvent(text, href, title)),
        );
      },
    );
  }
}
