import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale extends Equatable {
  final int? id;
  final int? invoiceId;
  final String item;
  final int itemPrice;
  final int itemQuantity;


  const Sale({
    this.id,
    this.invoiceId,
    required this.item,
    required this.itemPrice,
    required this.itemQuantity,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);

  Sale copyWith({
    int? id,
    int? invoiceId,
    String? item,
    int? itemPrice,
    int? itemQuantity,
  }) {
    return Sale(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        item: item ?? this.item,
        itemPrice: itemPrice ?? this.itemPrice,
        itemQuantity: itemQuantity ?? this.itemQuantity);
  }

  @override
  List<Object?> get props => [
    id,
    invoiceId,
    item,
    itemPrice,
    itemQuantity
  ];
}
