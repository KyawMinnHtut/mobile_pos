import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc({
    required PosRepository posReopository,
    required Person? initialPerson,
  })  : _posReopository = posReopository,
        super(
        DialogState(
          initialPerson: initialPerson,
          name: initialPerson?.name ?? '',
          phNumber: initialPerson?.phNumber ?? '',
          address: initialPerson?.address ?? '',
          isCustomer: initialPerson?.isCustomer ?? true,
        ),
      ) {
    on<DialogNameChanged>(_onNameChanged);
    on<DialogAddressChanged>(_onAddressChanged);
    on<DialogPhNumberChanged>(_onPhNumberChanged);
  on<DialogSubmitted>(_onSubmitted);
  on<DialogIsSupplierAsked>(_onAsked);
  }

  final PosRepository _posReopository;

  void _onNameChanged(
      DialogNameChanged event,
      Emitter<DialogState> emit,
      ) {
    emit(state.copyWith(name: event.name));
  }

  void _onAddressChanged(
      DialogAddressChanged event,
      Emitter<DialogState> emit,
      ) {
    emit(state.copyWith(address: event.address));
  }

  void _onPhNumberChanged(
      DialogPhNumberChanged event,
      Emitter<DialogState> emit,
      ) {
    emit(state.copyWith(phNumber: event.phNumber));
  }

  Future<void> _onAsked(DialogIsSupplierAsked event, Emitter<DialogState> emit) async {
    emit(state.copyWith(isCustomer: !event.isSupplier));
  }

  Future<void> _onSubmitted(
      DialogSubmitted event,
      Emitter<DialogState> emit,
      ) async {
    emit(state.copyWith(status: DialogStatus.loading));
    final person = (state.initialPerson ?? const Person(name: '', address: '', phNumber: '', isCustomer: true)).copyWith(
      name: state.name,
      address: state.address,
      phNumber: state.phNumber,
      isCustomer: state.isCustomer,
    );

    try {
      await _posReopository.savePerson(person);
      emit(state.copyWith(status: DialogStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DialogStatus.failure));
    }
  }
}