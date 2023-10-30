import 'package:equatable/equatable.dart';

abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object?> get props => [];
}

class OnCategoryChanged extends ArticlesEvent {
  final String category;

  const OnCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}