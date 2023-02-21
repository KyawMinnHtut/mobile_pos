part of 'expense_manager_bloc.dart';

abstract class ExpenseManagerEvent extends Equatable {
  const ExpenseManagerEvent();
  
  @override
  List<Object?> get props => [];
}

class ExpManagerSubscriptionRequested extends ExpenseManagerEvent {
  const ExpManagerSubscriptionRequested();
}

class ExpenseManagerDeleted extends ExpenseManagerEvent {
  final ExpenseManager expenseManager;

  const ExpenseManagerDeleted(this.expenseManager);

  @override
  List<Object?> get props => [expenseManager];
}

class ExpenseManagerFilterChanged extends ExpenseManagerEvent {
  final TranscationsViewFilter filter;

  const ExpenseManagerFilterChanged(this.filter);
  
}