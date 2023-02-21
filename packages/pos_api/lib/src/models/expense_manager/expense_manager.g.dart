// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseManager _$ExpenseManagerFromJson(Map<String, dynamic> json) =>
    ExpenseManager(
      id: json['id'] as int?,
      description: json['description'] as String,
      amount: json['amount'] as int,
      remark: json['remark'] as String,
      dateRecorded: DateTime.parse(json['dateRecorded'] as String),
      isIncome: json['isIncome'] as bool,
    );

Map<String, dynamic> _$ExpenseManagerToJson(ExpenseManager instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'amount': instance.amount,
      'remark': instance.remark,
      'isIncome': instance.isIncome,
      'dateRecorded': instance.dateRecorded.toIso8601String(),
    };
