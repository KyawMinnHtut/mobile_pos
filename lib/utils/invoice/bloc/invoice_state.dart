part of 'invoice_bloc.dart';

enum SaleStatus { initial, loading, success, failure }

class SaleState extends Equatable {
  const SaleState({
    this.status = SaleStatus.initial,
    this.sales = const [],
    this.filter = SaleViewFilter.invoiceNull,
    this.lastDeletedSale,
  });
  final SaleStatus status;
  final List<Sale> sales;
  final SaleViewFilter filter;
  final Sale? lastDeletedSale;

  SaleState copyWith({
    SaleStatus Function()? status,
    List<Sale> Function()? sales,
    SaleViewFilter Function()? filter,
    Sale Function()? lastDeletedSale,
  }) {
    return SaleState(
      status: status != null ? status() : this.status,
      sales: sales != null ? sales() : this.sales,
      filter: filter != null ? filter() : this.filter,
      lastDeletedSale:
          lastDeletedSale != null ? lastDeletedSale() : this.lastDeletedSale,
    );
  }

  @override
  List<Object?> get props => [status, sales, filter, lastDeletedSale];
}
