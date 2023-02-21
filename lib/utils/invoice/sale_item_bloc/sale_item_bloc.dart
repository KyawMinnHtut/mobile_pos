import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

part 'sale_item_event.dart';
part 'sale_item_state.dart';

class SaleItemBloc extends Bloc<SaleItemEvent, SaleItemState> {
  final PosRepository _posRepository;
  SaleItemBloc(
      {required PosRepository posRepository, Sale? initialSale})
      : _posRepository = posRepository,
        super(const SaleItemState()) {
    on<SaleItemQtyDecreased>(_onSaleItemQtyDecreased);
    on<SaleItemQtyIncreased>(_onSaleItemQtyIncreased);
  }

  void _onSaleItemQtyIncreased(SaleItemQtyIncreased event, Emitter<SaleItemState> emit) async{
    final sale = (state.initialSale ?? const Sale(item: '', itemPrice: 0, itemQuantity: 0)).copyWith(
      itemQuantity: state.saleItemQty,
    );
    try {
      await _posRepository.updateSale(sale, true);
      emit(state.copyWith(status: SaleItemStatus.success));
    } catch (e){
      emit(state.copyWith(status: SaleItemStatus.failure));
    }
  }

  void _onSaleItemQtyDecreased(SaleItemQtyDecreased event, Emitter<SaleItemState> emit) async{
    final sale = (state.initialSale ?? const Sale(item: '', itemPrice: 0, itemQuantity: 0)).copyWith(
      itemQuantity: state.saleItemQty,
    );
    try {
      await _posRepository.updateSale(sale, false);
      emit(state.copyWith(status: SaleItemStatus.success));
    } catch (e){
      emit(state.copyWith(status: SaleItemStatus.failure));
    }
  }

  // Future<void> _onSubmitted(SaleItemSubmitted event, Emitter<SaleItemState> emit) async{
  //   emit(state.copyWith(status: SaleItemStatus.loading));
  //   final sale = (state.initialSale ?? Sale(item: '', itemPrice: 0, itemQuantity: 0)).copyWith(
  //     item: state.
  //   );
  // }
}
