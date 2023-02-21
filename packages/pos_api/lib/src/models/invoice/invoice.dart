import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice extends Equatable {
  final int? id;
  final String person;
  final DateTime dateRecorded;
  final int totalAmount;
  final bool isSale;


  const Invoice({
    this.id,
    required this.person,
    required this.dateRecorded,
    required this.totalAmount,
    required this.isSale,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  Invoice copyWith({
    int? id,
    String? person,
    DateTime? dateRecorded,
    int? totalAmount,
    bool? isSale,
  }) {
    return Invoice(
        id: id ?? this.id,
        person: person ?? this.person,
        dateRecorded: dateRecorded ?? this.dateRecorded,
        totalAmount: totalAmount ?? this.totalAmount,
        isSale: isSale ?? this.isSale);
  }

  @override
  List<Object?> get props => [
    id,
    person,
    dateRecorded,
    totalAmount,
    isSale
  ];
}