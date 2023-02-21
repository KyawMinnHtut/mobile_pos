part of 'sales_bloc.dart';

abstract class InvoicesEvent extends Equatable {
  const InvoicesEvent();

  @override
  List<Object> get props => [];
}

class InvoicesSubscriptionRequested extends InvoicesEvent {
  const InvoicesSubscriptionRequested();
}

class InvoiceDeleted extends InvoicesEvent {
  const InvoiceDeleted(this.invoice);

  final Invoice invoice;

  @override
  List<Object> get props => [invoice];
}

class InvoiceUndoDeletionRequested extends InvoicesEvent {
  const InvoiceUndoDeletionRequested();
}

class InvoicesFilterChanged extends InvoicesEvent {
  final InvoicesViewFilter filter;

  const InvoicesFilterChanged(this.filter);
}
