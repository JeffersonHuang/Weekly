part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class ArticleFetchEvent extends ArticleEvent {
  final String link;

  const ArticleFetchEvent(this.link);
}

class ArticleOpenBrowserEvent extends ArticleEvent {
  final String text;
  final String? href;
  final String title;

  const ArticleOpenBrowserEvent(this.text, this.href, this.title);
}
