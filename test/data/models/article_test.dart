
import 'dart:convert';

import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/article.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

//we test 3 things here, is model from data the same as domain one, is fromJson returning exact model, is toJson working
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

  test('should be a subclass of article entity', () async {
      //assert
       expect(testArticleModel, isA<ArticleEntity>());
  });

  test('should be a valid article model', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_article_response.json'),
    );
    //act
    final result = ArticleModel.fromJson(jsonMap);

    //assert
    expect(result, testArticleModel);
  });

  test('should be a valid json format', () {
    final data = {
      "author": "Chris Isidore, Vanessa Yurkevich",
      "title":
      "UAW reaches tentative agreement with Stellantis, expands strike at GM - CNN",
      "description":
      "The UAW has reached a tentative agreement with Stellantis, which makes vehicles under the Dodge, Ram, Chrysler and Jeep brands.",
      "url":
      "https://www.cnn.com/2023/10/28/business/uaw-stellantis-deal/index.html",
      "urlToImage":
      "https://media.cnn.com/api/v1/images/stellar/prod/231027165526-uaw-walk-out-09222023.jpg?c=16x9&q=w_800,c_fill",
      "publishedAt": "2023-10-29T01:51:00Z",
      "content":
      "The United Auto Workers unioncame to a tenative agreement with Stellantis Saturday. But it expanded the strike against General Motors, Americas largest automaker and the last remaining Big Three hold… [+8575 chars]"
    };

    //act

    final result = testArticleModel.toJson();

    //assert
    expect(result, data);
  });
}