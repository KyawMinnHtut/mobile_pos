// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      category: json['category'] as String,
      purchasePrice: json['purchasePrice'] as int,
      retailPrice: json['retailPrice'] as int,
      wholesalePrice: json['wholesalePrice'] as int,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'category': instance.category,
      'purchasePrice': instance.purchasePrice,
      'retailPrice': instance.retailPrice,
      'wholesalePrice': instance.wholesalePrice,
      'description': instance.description,
    };
