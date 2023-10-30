import 'dart:convert';

import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/models/source.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  final testSourceModel = SourceModel(id: "cnn", name: "CNN");

  test('should be a subclass of source entity', () {
    //assert
    expect(testSourceModel, isA<SourceEntity>());
  });

  test('should return valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_source_response.json'),
    );

    //act
    final result = SourceModel.fromJson(jsonMap);

    //assert
    expect(result, testSourceModel);
  });
  
  test('should return a valid json format', () {
    final expectedJson = {
      'id': 'cnn',
      'name': 'CNN'
    };

    //assert
    final result = testSourceModel.toJson();


    //assert
    expect(result, expectedJson);
  });
}