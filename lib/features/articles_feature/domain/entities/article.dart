import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/source.dart';

class ArticleEntity extends Equatable {
  SourceEntity? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  ArticleEntity({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

  ArticleEntity.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null ? SourceEntity?.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source!.toJson();
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }

  @override
  List<Object?> get props =>
      [author, title, description, url, urlToImage, publishedAt, content, source];
}
