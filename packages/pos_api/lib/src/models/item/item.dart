import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../pos_api.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final String name;
  final int quantity;
  final String category;
  final int purchasePrice;
  final int retailPrice;
  final int wholesalePrice;
  final String description;

  const Item({
    required this.name,
    required this.quantity,
    required this.category,
    required this.purchasePrice,
    required this.retailPrice,
    required this.wholesalePrice,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    String? category,
    String? name,
    int? quantity,
    int? purchasePrice,
    int? retailPrice,
    int? wholesalePrice,
    String? description,
  }) {
    return Item(
        category: category ?? this.category,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        retailPrice: retailPrice ?? this.retailPrice,
        wholesalePrice: wholesalePrice ?? this.wholesalePrice,
        description: description ?? this.description);
  }

  @override
  List<Object?> get props => [
        category,
        name,
        quantity,
        purchasePrice,
        retailPrice,
        wholesalePrice,
        description
      ];
}
