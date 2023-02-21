import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final PosRepository _posRepository;
  ItemBloc({required PosRepository posRepository, required Item? initialItem})
      : _posRepository = posRepository,
        super(ItemState(
            initialItem: initialItem,
            name: initialItem?.name ?? '',
            qty: initialItem?.quantity ?? 0,
            category: initialItem?.category ?? '',
            purchasePrice: initialItem?.purchasePrice ?? 0,
            retailPrice: initialItem?.retailPrice ?? 0,
            wholesalePrice: initialItem?.wholesalePrice ?? 0,
            desc: initialItem?.description ?? '')) {
    on<ItemNamedChanged>(_onNameChanged);
    on<ItemQtyChanged>(_onQtyChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<ItemPurchasePriceChanged>(_onPurchsePriceChanged);
    on<ItemRetailPriceChanged>(_onRetailPriceChanged);
    on<ItemWholeSalePriceChanged>(_onWholesalePriceChanged);
    on<ItemDescChanged>(_onDescChanged);
    on<ItemSubmitted>(_onSubmitted);
  }

  void _onNameChanged(
    ItemNamedChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onQtyChanged(
    ItemQtyChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(qty: event.qty));
  }

  void _onPurchsePriceChanged(
    ItemPurchasePriceChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(purchasePrice: event.purchasePrice));
  }

  void _onRetailPriceChanged(
    ItemRetailPriceChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(retailPrice: event.retailPrice));
  }

  void _onWholesalePriceChanged(
    ItemWholeSalePriceChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(wholesalePrice: event.wholesalePrice));
  }

  void _onDescChanged(
    ItemDescChanged event,
    Emitter<ItemState> emit,
  ) {
    emit(state.copyWith(desc: event.desc));
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<ItemState> emit) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _onSubmitted(
    ItemSubmitted event,
    Emitter<ItemState> emit,
  ) async {
    emit(state.copyWith(status: ItemStatus.loading));
    final item = (state.initialItem ??
            const Item(
                name: '',
                quantity: 0,
                category: '',
                purchasePrice: 0,
                retailPrice: 0,
                wholesalePrice: 0,
                description: ''))
        .copyWith(
      description: state.desc,
      name: state.name,
      quantity: state.qty,
      category: state.category,
      purchasePrice: state.purchasePrice,
      retailPrice: state.retailPrice,
      wholesalePrice: state.wholesalePrice,
    );
    try {
      await _posRepository.saveItem(item);
      emit(state.copyWith(status: ItemStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ItemStatus.failure));
    }
  }
}
