// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      id: json['id'] as int?,
      invoiceId: json['invoiceId'] as int?,
      item: json['item'] as String,
      itemPrice: json['itemPrice'] as int,
      itemQuantity: json['itemQuantity'] as int,
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'item': instance.item,
      'itemPrice': instance.itemPrice,
      'itemQuantity': instance.itemQuantity,
    };
