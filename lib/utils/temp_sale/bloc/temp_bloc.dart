import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_pos/utils/temp_sale/temp_date.dart';
import 'package:pos_repository/pos_repository.dart';
import 'package:rxdart/subjects.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  TempBloc() : super(const TempState()) {
    // on<TempListRequested>(_onItemsRequested);
    // on<TempItemDeleted>(_onItemDeleted);
  }

  // Future<void> _onItemsRequested(
  //     TempListRequested event, Emitter<TempState> emit) async {
  //   await emit.forEach<List<Item>>(TempData().itemsList,
  //       onData: (items) => state.copyWith(
  //           status: () => TempStatus.success, items: () => items),
  //       onError: (_, __) => state.copyWith(status: () => TempStatus.failure));
  // }

  // void _onItemsAdded (TempItemAdded event, Emitter<TempState> emit) {
  //
  // }

  // void _onItemDeleted(TempItemDeleted event, Emitter<TempState> emit) {
  //   emit(state.copyWith(lastDeletedItem: () => event.item));
  //   TempData().deleteItem(event.item.name);
  // }
}
