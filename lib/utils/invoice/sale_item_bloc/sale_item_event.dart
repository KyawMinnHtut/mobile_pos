part of 'sale_item_bloc.dart';

abstract class SaleItemEvent extends Equatable {
  const SaleItemEvent();

  @override
  List<Object?> get props => [];
}

class SaleItemQtyIncreased extends SaleItemEvent{

  final int itemQty;

  const SaleItemQtyIncreased(this.itemQty);

  @override
  List<Object?> get props => [itemQty];
}

class SaleItemQtyDecreased extends SaleItemEvent{

  final int itemQty;

  const SaleItemQtyDecreased(this.itemQty);

  @override
  List<Object?> get props => [itemQty];
}

class SaleItemSubmitted extends SaleItemEvent {
  const SaleItemSubmitted();
}
