import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/article.dart';
import 'package:intl/intl.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel(
      {required String author,
      required String title,
      required String description,
      required String url,
      required String urlToImage,
      required DateTime publishedAt,
      required String content})
      : super(
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  ArticleEntity toEntity() {
    return ArticleEntity(
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? '');

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': '${DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(publishedAt!)}Z',
        'content': content
      };
}
