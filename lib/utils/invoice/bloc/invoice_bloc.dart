import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_pos/utils/invoice/models/model.dart';
import 'package:pos_repository/pos_repository.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final PosRepository _posRepository;
  SaleBloc({required PosRepository posRepository})
      : _posRepository = posRepository,
        super(const SaleState()) {
    on<SaleListRequested>(_onSubscriptionRequested);
    on<SaleItemDeleted>(_onSaleItemDeleted);
    on<SaleFilterChanged>(_onFilterChanged);
  }

  Future<void> _onSubscriptionRequested(
      SaleListRequested event, Emitter<SaleState> emit) async {
    emit(state.copyWith(status: () => SaleStatus.loading));
    await emit.forEach<List<Sale>>(
        _posRepository.getSales(),
        onData: (sales) => state.copyWith(
          status: () => SaleStatus.success,
          sales: () => sales,
        ),
        onError: (_, __) => state.copyWith(
          status: () => SaleStatus.failure,
        )
    );
  }

  Future<void> _onSaleItemDeleted(SaleItemDeleted event, Emitter<SaleState> emit) async {
    emit(state.copyWith(lastDeletedSale: () => event.sale));
    await _posRepository.deleteSale(event.sale);
  }

  void _onFilterChanged(SaleFilterChanged event, Emitter<SaleState> emit){
    emit(state.copyWith(filter: () => event.filter));
  }
}
