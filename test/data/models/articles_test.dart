import 'dart:convert';

import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
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
      "The United Auto Workers unioncame to a tenative agreement with Stellantis Saturday. But it expanded the strike against General Motors, Americas largest automaker and the last remaining Big Three hold… [+8575 chars]"
  );
  final testArticlesModel = ArticlesModel(articles: [testArticleModel], status: "ok", totalResults: 1);

  test('should be a subclass of article entity', () {
    expect(testArticlesModel, isA<ArticlesEntity>());
  });

  test('should a valid articles model', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_articles_response.json'),
    );
    //act
    final result = ArticlesModel.fromJson(jsonMap);

    //assert
    expect(result, testArticlesModel);
  });
}
