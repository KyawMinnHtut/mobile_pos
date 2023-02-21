// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      phNumber: json['phNumber'] as String,
      address: json['address'] as String,
      isCustomer: json['isCustomer'] as bool,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'phNumber': instance.phNumber,
      'address': instance.address,
      'isCustomer': instance.isCustomer,
    };
