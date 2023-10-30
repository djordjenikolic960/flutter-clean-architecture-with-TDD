import 'dart:convert';

import 'package:flutter_clean_architecture_and_tdd/core/constants/constants.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/exception.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/articles.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRemoteDataSource {
  Future<ArticlesModel> getArticlesByCategory(String category);
}

class ArticleRemoteDataSourceImpl extends ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl({required this.client});

  @override
  Future<ArticlesModel> getArticlesByCategory(String category) async {
    final response =
        await client.get(Uri.parse(Urls.articlesByCategory(category)));

    if (response.statusCode == 200) {
      return ArticlesModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
