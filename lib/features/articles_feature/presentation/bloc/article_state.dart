import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object?> get props => [];
}

class ArticlesEmpty extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final ArticlesEntity result;

  const ArticlesLoaded(this.result);

   @override
  List<Object?> get props => [result];
}

class ArticlesLoadFailure extends ArticlesState {
  final String message;

  const ArticlesLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}