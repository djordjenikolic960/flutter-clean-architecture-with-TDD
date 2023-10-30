import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/article.dart';

class ArticlesEntity extends Equatable {
  String? status;
  int? totalResults;
  List<ArticleEntity?>? articles;

  ArticlesEntity({this.status, this.totalResults, this.articles});

  ArticlesEntity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <ArticleEntity>[];
      json['articles'].forEach((v) {
        articles!.add(ArticleEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    data['articles'] =
        articles != null ? articles!.map((v) => v?.toJson()).toList() : null;
    return data;
  }

  @override
  List<Object?> get props => [status, totalResults, articles];
}
