import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/exception.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/data_sources/article_remote_data_source.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/repositories/articles_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  @override
  Future<Either<Failure, ArticlesEntity>> getArticlesByCategory(
      String category) async {
    try {
      final result =
          await articleRemoteDataSource.getArticlesByCategory(category);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("there was a server error"));
    } on SocketException {
      return const Left(ConnectionFailure("there was a connection error"));
    }
  }
}
