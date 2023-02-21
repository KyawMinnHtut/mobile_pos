import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_pos/expense_manager/models/models.dart';
import 'package:pos_repository/pos_repository.dart';

part 'expense_manager_event.dart';
part 'expense_manager_state.dart';

class ExpenseManagerBloc extends Bloc<ExpenseManagerEvent, ExpenseManagerState> {
  final PosRepository _posReopository;
  ExpenseManagerBloc({required PosRepository posReopository}) : _posReopository = posReopository, super(const ExpenseManagerState()) {
    on<ExpManagerSubscriptionRequested>(_onSubscriptoinRequested);
    on<ExpenseManagerDeleted>(_onDeleted);
    on<ExpenseManagerFilterChanged>(_onFilterChanged);
  }

  Future<void> _onSubscriptoinRequested(ExpManagerSubscriptionRequested event, Emitter<ExpenseManagerState> emit) async{
    emit(state.copyWith(status: () => TransactionStatus.loading));
    await emit.forEach<List<ExpenseManager>>(_posReopository.getExpenseManagers(),
        onData: (datas) => state.copyWith(
          status: () => TransactionStatus.success,
          expenseManagers: () => datas
        ),
      onError: (_, __) => state.copyWith(status: () => TransactionStatus.failure),
    );
  }

  Future<void> _onDeleted(ExpenseManagerDeleted event, Emitter<ExpenseManagerState> emit) async {
    emit(state.copyWith(lastDeletedExpenseManager: () => event.expenseManager));
    await _posReopository.deleteExpenseManager(event.expenseManager.id!);
  }

  void _onFilterChanged(ExpenseManagerFilterChanged event, Emitter<ExpenseManagerState> emit){
    emit(state.copyWith(filter: () => event.filter));
  }
}
