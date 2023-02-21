part of 'invoice_bloc.dart';

abstract class SaleEvent extends Equatable {
  const SaleEvent();

  @override
  List<Object?> get props => [];
}

class SaleListRequested extends SaleEvent {
  const SaleListRequested();
}

// class TempItemAdded extends TempEvent {
//   final Sale item;
//
//   const TempItemAdded(this.item);
//
//   @override
//   List<Object?> get props => [item];
//
// }

class SaleItemDeleted extends SaleEvent {
  final Sale sale;

  const SaleItemDeleted(this.sale);

  @override
  List<Object?> get props => [sale];

}

class SaleFilterChanged extends SaleEvent {
  final SaleViewFilter filter;

  const SaleFilterChanged(this.filter);

}

// class SaleItemQtyIncreased extends SaleEvent {
//
// }
