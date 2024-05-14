import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repo/repo.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesFetchEvent>((event, emit) async {
      emit(CategoriesLoadingState());
      final categories = await weeklyRepo.getAllCategories();

      emit(CategoriesSuccessState(categories));
    });
  }
}
