part of 'sale_item_bloc.dart';

enum SaleItemStatus { initial, loading, success, failure }

extension SaleItemStatusX on SaleItemStatus {
  bool get isLoadingOrSuccess => [
        SaleItemStatus.loading,
        SaleItemStatus.success,
      ].contains(this);
}

class SaleItemState extends Equatable {
  const SaleItemState({this.status = SaleItemStatus.initial, this.initialSale, this.saleItemQty = 0});

  final SaleItemStatus status;
  final Sale? initialSale;
  final int saleItemQty;

  bool get isNewSaleItem => initialSale == null;

  SaleItemState copyWith({
  SaleItemStatus? status,
    Sale? initialSale,
    int? saleItemQty,
}){
    return SaleItemState(
      status: status ?? this.status,
      initialSale: initialSale ?? this.initialSale,
      saleItemQty: saleItemQty ?? this.saleItemQty,
    );
  }

  @override
  List<Object?> get props => [status, initialSale, saleItemQty];
}
