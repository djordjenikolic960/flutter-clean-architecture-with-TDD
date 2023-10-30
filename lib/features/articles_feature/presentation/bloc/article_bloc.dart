import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/usecases/get_articles_by_category.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_event.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticlesByCategoryUseCase _getArticlesByCategoryUseCase;

  ArticlesBloc(this._getArticlesByCategoryUseCase) : super(ArticlesEmpty()) {
    on<OnCategoryChanged>(_onCategoryChanged);
  }

  void _onCategoryChanged(
      OnCategoryChanged event, Emitter<ArticlesState> emit) async {
    emit(ArticlesLoading());
    final result = await _getArticlesByCategoryUseCase.execute(event.category);
    result.fold((failure) {
      emit(ArticlesLoadFailure(failure.message));
    }, (data) {
      emit(ArticlesLoaded(data));
    });
  }
}
