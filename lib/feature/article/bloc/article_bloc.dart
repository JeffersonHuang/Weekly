import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weekly/data/repo/repo.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleState('')) {
    on<ArticleFetchEvent>((event, emit) async {
      final res = await weeklyRepo.getWeekly(url: event.link);
      emit(ArticleState(res));
    });

    on<ArticleOpenBrowserEvent>((event, emit) async {
      _openBrowser(event.text, event.href, event.title);
    });
  }

  void _openBrowser(String text, String? href, String title) {
    if (href == null) {
      return;
    }
    final url = Uri.parse(href);
    launchUrl(url);
  }
}
