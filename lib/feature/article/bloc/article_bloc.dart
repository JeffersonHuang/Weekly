import 'package:bloc/bloc.dart';
import 'package:weekly/data/repo/repo.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleFetchEvent, ArticleState> {
  ArticleBloc() : super(ArticleState('')) {
    on<ArticleFetchEvent>((event, emit) async {
      final res = await weeklyRepo.getWeekly(url: event.link);
      emit(ArticleState(res));
    });
  }
}
