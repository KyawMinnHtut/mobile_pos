part of 'sales_bloc.dart';

enum InvoicesStatus { initial, loading, success, failure }

class InvoicesState extends Equatable {
  const InvoicesState({
    this.status = InvoicesStatus.initial,
    this.invoices = const [],
    this.filter = InvoicesViewFilter.all,
    this.deletedInvoice,
  });

  final InvoicesStatus status;
  final List<Invoice> invoices;
  final InvoicesViewFilter filter;
  final Invoice? deletedInvoice;

  Iterable<Invoice> get filteredInvoices => filter.applyAll(invoices);

  InvoicesState copyWith({
    InvoicesStatus Function()? status,
    List<Invoice> Function()? invoices,
    InvoicesViewFilter Function()? filter,
    Invoice? Function()? deletedInvoice,
  }) {
    return InvoicesState(
      status: status != null ? status() : this.status,
      invoices: invoices != null ? invoices() : this.invoices,
      filter: filter != null ? filter() : this.filter,
      deletedInvoice: deletedInvoice != null ? deletedInvoice() : this.deletedInvoice,
    );
  }

  @override
  List<Object?> get props => [
        status,
        invoices,
        filter,
        deletedInvoice,
      ];
}
