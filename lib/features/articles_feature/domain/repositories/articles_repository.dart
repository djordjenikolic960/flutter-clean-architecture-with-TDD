import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';

abstract class ArticleRepository {

  Future<Either<Failure, ArticlesEntity>> getArticlesByCategory(String category);
}