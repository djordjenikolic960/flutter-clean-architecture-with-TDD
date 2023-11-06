import 'dart:io';

import 'package:flutter_clean_architecture_and_tdd/core/constants/constants.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/exception.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/data_sources/article_remote_data_source.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/articles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late ArticleRemoteDataSourceImpl articleRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    articleRemoteDataSourceImpl = ArticleRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String category = 'business';
  group('get articles for category', () {
    test('should return articles model with status code 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.articlesByCategory(category)))).thenAnswer((_) async => http.Response(
          readJson('helpers/dummy_data/dummy_articles_response.json'),
        200,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      ));

      //act
      final result = await articleRemoteDataSourceImpl.getArticlesByCategory(category);
      //assert

      expect(result, isA<ArticlesModel>());
    });

    test('should throw server exception with status code 404', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.articlesByCategory(category)))).thenAnswer((_) async => http.Response(
        'server error',
        404,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      ));

      //act
      final result = articleRemoteDataSourceImpl.getArticlesByCategory(category);
      //assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}