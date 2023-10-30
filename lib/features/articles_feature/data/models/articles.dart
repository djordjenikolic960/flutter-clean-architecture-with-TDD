import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';

class ArticlesModel extends ArticlesEntity {
  ArticlesModel(
      {required List<ArticleModel>? articles,
      required String status,
      required int totalResults})
      : super(articles: articles, status: status, totalResults: totalResults);

  factory ArticlesModel.fromJson(Map<String, dynamic> jsonMap) => ArticlesModel(
        articles: (jsonMap['articles'] != null)
            ? List<ArticleModel>.from(
                jsonMap['articles'].map((v) => ArticleModel.fromJson(v)))
            : null,
        status: jsonMap['status'],
        totalResults: jsonMap['totalResults'],
      );

  ArticlesEntity toEntity() {
    return ArticlesEntity(
      articles: articles,
      status: status,
      totalResults: totalResults
    );
  }
}
