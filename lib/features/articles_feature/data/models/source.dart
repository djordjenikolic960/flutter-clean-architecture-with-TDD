import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/source.dart';

class SourceModel extends SourceEntity {
  SourceModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      SourceModel(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  }
