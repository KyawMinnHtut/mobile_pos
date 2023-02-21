import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final String name;
  final String description;

  const Category({
    required this.name,
    required this.description
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category copyWith({
    String? name,
    String? description
  }){
    return Category(name: name ?? this.name, description: description ?? this.description);
  }

  @override
  List<Object?> get props => [name, description];
}