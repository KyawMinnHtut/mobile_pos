part of 'expense_manager_bloc.dart';

enum TransactionStatus { initial, loading, success, failure }

class ExpenseManagerState extends Equatable {
  const ExpenseManagerState({
    this.status = TransactionStatus.initial,
    this.expenseManagers = const [],
    this.filter = TranscationsViewFilter.all,
    this.lastDeletedExpenseManager,
  });

  final TransactionStatus status;
  final List<ExpenseManager> expenseManagers;
  final ExpenseManager? lastDeletedExpenseManager;
  final TranscationsViewFilter filter;

  Iterable<ExpenseManager> get filteredTransactions =>
      filter.applyAll(expenseManagers);

  ExpenseManagerState copyWith({
    TransactionStatus Function()? status,
    List<ExpenseManager> Function()? expenseManagers,
    ExpenseManager? Function()? lastDeletedExpenseManager,
    TranscationsViewFilter Function()? filter,
  }) {
    return ExpenseManagerState(
      status: status != null ? status() : this.status,
      expenseManagers:
          expenseManagers != null ? expenseManagers() : this.expenseManagers,
      filter: filter != null ? filter() : this.filter,
      lastDeletedExpenseManager: lastDeletedExpenseManager != null
          ? lastDeletedExpenseManager()
          : this.lastDeletedExpenseManager,
    );
  }

  @override
  List<Object?> get props =>
      [status, expenseManagers, lastDeletedExpenseManager, filter];
}
