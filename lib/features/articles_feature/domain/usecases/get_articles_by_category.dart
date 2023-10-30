import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/repositories/articles_repository.dart';

class GetArticlesByCategoryUseCase {
  final ArticleRepository articleRepository;

  GetArticlesByCategoryUseCase(this.articleRepository);

  Future<Either<Failure, ArticlesEntity>> execute(String category) {
     return articleRepository.getArticlesByCategory(category);
  }
}