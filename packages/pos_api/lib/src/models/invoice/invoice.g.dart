// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'] as int?,
      person: json['person'] as String,
      dateRecorded: DateTime.parse(json['dateRecorded'] as String),
      totalAmount: json['totalAmount'] as int,
      isSale: json['isSale'] as bool,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'person': instance.person,
      'dateRecorded': instance.dateRecorded.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'isSale': instance.isSale,
    };
