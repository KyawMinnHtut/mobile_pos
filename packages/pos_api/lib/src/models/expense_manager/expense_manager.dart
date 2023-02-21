import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_manager.g.dart';

@JsonSerializable()
class ExpenseManager extends Equatable {
  final int? id;
  final String description;
  final int amount;
  final String remark;
  final bool isIncome;
  final DateTime dateRecorded;

  const ExpenseManager(
      { this.id,
      required this.description,
      required this.amount,
      required this.remark,
        required this.dateRecorded,
      required this.isIncome});

  factory ExpenseManager.fromJson(Map<String, dynamic> json) =>
      _$ExpenseManagerFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseManagerToJson(this);

  ExpenseManager copyWith(
      {int? id,
      String? description,
      int? amount,
      String? remark,
        DateTime? dateRecorded,
      bool? isIncome}) {
    return ExpenseManager(
        id: id ?? this.id,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        remark: remark ?? this.remark,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        isIncome: isIncome ?? this.isIncome);
  }

  @override
  List<Object?> get props => [id, description, amount, remark, isIncome, dateRecorded];
}
