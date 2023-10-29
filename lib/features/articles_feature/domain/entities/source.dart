import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  String? id;
  String? name;

  SourceEntity({this.id, this.name});

  SourceEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [id, name];
}
