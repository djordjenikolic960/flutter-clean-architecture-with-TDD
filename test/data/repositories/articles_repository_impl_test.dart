import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/exception.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/repositories/article_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockArticleRemoteDataSource mockArticleRemoteDataSource;
  late ArticleRepositoryImpl articleRepositoryImpl;

  final testArticleModel = ArticleModel(
      author: "Chris Isidore, Vanessa Yurkevich",
      title:
          "UAW reaches tentative agreement with Stellantis, expands strike at GM - CNN",
      description:
          "The UAW has reached a tentative agreement with Stellantis, which makes vehicles under the Dodge, Ram, Chrysler and Jeep brands.",
      url:
          "https://www.cnn.com/2023/10/28/business/uaw-stellantis-deal/index.html",
      urlToImage:
          "https://media.cnn.com/api/v1/images/stellar/prod/231027165526-uaw-walk-out-09222023.jpg?c=16x9&q=w_800,c_fill",
      publishedAt: DateTime.parse("2023-10-29T01:51:00Z"),
      content:
          "The United Auto Workers unioncame to a tenative agreement with Stellantis Saturday. But it expanded the strike against General Motors, Americas largest automaker and the last remaining Big Three hold… [+8575 chars]");
  final testArticlesModel = ArticlesModel(
      articles: [testArticleModel], status: "ok", totalResults: 1);

  const String category = "business";
  setUp(() {
    mockArticleRemoteDataSource = MockArticleRemoteDataSource();
    articleRepositoryImpl = ArticleRepositoryImpl(
        articleRemoteDataSource: mockArticleRemoteDataSource);
  });

  group('get articles', () {
    test('should return articles when a call to api is successful', () async {
      //arrange
      when(mockArticleRemoteDataSource.getArticlesByCategory(category))
          .thenAnswer((_) async => testArticlesModel);

      //act
      final result =
          await articleRepositoryImpl.getArticlesByCategory(category);
      // Convert testArticlesModel to ArticlesEntity
      final expectedEntity = testArticlesModel.toEntity();
      //assert
      expect(result, equals(Right(expectedEntity)));
    });

    test('should throw server error when is unsuccessful', () async {
      //arrange
      when(mockArticleRemoteDataSource.getArticlesByCategory(category))
          .thenThrow(ServerException());

      //act
      final result =
          await articleRepositoryImpl.getArticlesByCategory(category);
      //assert
      expect(result,
          equals(const Left(ServerFailure("there was a server error"))));
    });

    test('should throw socket error when is unsuccessful', () async {
      //arrange
      when(mockArticleRemoteDataSource.getArticlesByCategory(category))
          .thenThrow(const SocketException("there was a connection error"));

      //act
      final result =
          await articleRepositoryImpl.getArticlesByCategory(category);
      //assert
      expect(
          result,
          equals(
              const Left(ConnectionFailure("there was a connection error"))));
    });
  });
}
