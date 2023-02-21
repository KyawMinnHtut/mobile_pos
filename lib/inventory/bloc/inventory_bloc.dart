import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

import '../inventory.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final PosRepository _posRepository;
  InventoryBloc({required PosRepository posRepository})
      : _posRepository = posRepository,
        super(const InventoryState()) {
    on<InventorySubscriptionRequested>(_onSubscriptionRequested);
    on<InventoryDeleted>(_onItemDeleted);
    on<InventoryFilterChanged>(_onFilteredChanged);
  }

  Future<void> _onSubscriptionRequested(InventorySubscriptionRequested event,
      Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: () => InventoryStatus.loading));
    await emit.forEach<List<Item>>(_posRepository.getAllItems(),
        onError: (_, __) => state.copyWith(
          status: () => InventoryStatus.failure
        ),
        onData: (items) => state.copyWith(
            status: () => InventoryStatus.success, items: () => items));
  }

  Future<void> _onItemDeleted(
      InventoryDeleted event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(lastDeletedItem: () => event.item));
    await _posRepository.deleteItem(event.item.name!);
  }

  void _onFilteredChanged(
      InventoryFilterChanged event, Emitter<InventoryState> emit) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
