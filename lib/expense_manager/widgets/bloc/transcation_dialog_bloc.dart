import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

part 'transcation_dialog_event.dart';
part 'transcation_dialog_state.dart';

class TransactionDialogBloc extends Bloc<TransactionDialogEvent, TransactionDialogState> {
  TransactionDialogBloc({
    required PosRepository posRepository,
    ExpenseManager? initialTransaction,
  })  : _posRepository = posRepository,
        super(
        TransactionDialogState(
          initialTransaction: initialTransaction,
          desc: initialTransaction?.description ?? '',
          amount: initialTransaction?.amount ?? 0,
          remark: initialTransaction?.remark ?? '',
          isIncome: initialTransaction?.isIncome ?? true,
        ),
      ) {
    on<DialogDescChanged>(_onDescChanged);
    on<DialogAmountChanged>(_onAmountChanged);
    on<DialogRemarkChanged>(_onRemarkChanged);
    on<DialogSubmitted>(_onSubmitted);
  }

  final PosRepository _posRepository;

  void _onDescChanged(
      DialogDescChanged event,
      Emitter<TransactionDialogState> emit,
      ) {
    emit(state.copyWith(desc: event.desc));
  }

  void _onAmountChanged(
      DialogAmountChanged event,
      Emitter<TransactionDialogState> emit,
      ) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onRemarkChanged(
      DialogRemarkChanged event,
      Emitter<TransactionDialogState> emit,
      ) {
    emit(state.copyWith(remark: event.remark));
  }

  Future<void> _onSubmitted(
      DialogSubmitted event,
      Emitter<TransactionDialogState> emit,
      ) async {
    emit(state.copyWith(status: TransactionDialogStatus.loading));
    final expenseManager = (state.initialTransaction ?? ExpenseManager(description: '', amount: 0, remark: '', dateRecorded: DateTime.now(), isIncome: true)).copyWith(
      description: state.desc,
      amount: state.amount,
      remark: state.remark,
      dateRecorded: DateTime.now(),
      isIncome: event.isIncome ?? state.isIncome,
    );

    try {
      await _posRepository.saveExpenseManager(expenseManager);
      emit(state.copyWith(status: TransactionDialogStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TransactionDialogStatus.failure));
    }
  }
}
