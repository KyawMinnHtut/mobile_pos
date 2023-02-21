import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

import '../sale.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class InvoicesBloc extends Bloc<InvoicesEvent, InvoicesState> {
  final PosRepository _posRepository;
  InvoicesBloc({required PosRepository posRepository})
      : _posRepository = posRepository,
        super(const InvoicesState()) {
    on<InvoicesSubscriptionRequested>(_onSubscriptionRequested);
    on<InvoiceDeleted>(_onInvoiceDeleted);
    on<InvoicesFilterChanged>(_onFilterChanged);
    on<InvoiceUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  Future<void> _onSubscriptionRequested(
      InvoicesSubscriptionRequested event, Emitter<InvoicesState> emit) async {
    emit(state.copyWith(status: () => InvoicesStatus.loading));
    await emit.forEach<List<Invoice>>(
        _posRepository.getInvoices(isSale: true),
        onData: (invoices) => state.copyWith(
          status: () => InvoicesStatus.success,
          invoices: () => invoices,
        ),
        onError: (_, __) => state.copyWith(
          status: () => InvoicesStatus.failure,
        )
    );
  }

  Future<void> _onInvoiceDeleted(InvoiceDeleted event, Emitter<InvoicesState> emit) async {
    emit(state.copyWith(deletedInvoice: () => event.invoice));
    await _posRepository.deleteInvoice(event.invoice.id!);
  }

  void _onFilterChanged(InvoicesFilterChanged event, Emitter<InvoicesState> emit){
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onUndoDeletionRequested(InvoiceUndoDeletionRequested event, Emitter<InvoicesState> emit) async{
    assert(state.deletedInvoice != null, 'Deleted person cannot be null');
    final invoice = state.deletedInvoice!;
    emit(state.copyWith(deletedInvoice: () => null));
    await _posRepository.saveInvoice(invoice);
  }
}
