import 'package:pos_repository/pos_repository.dart';

enum TranscationsViewFilter {all, income, expense}

extension TranscationViewFilterX on TranscationsViewFilter {
  bool apply (ExpenseManager expenseManager) {
    switch (this) {
      case TranscationsViewFilter.all:
        return true;
      case TranscationsViewFilter.income:
        return expenseManager.isIncome;
      case TranscationsViewFilter.expense:
        return !expenseManager.isIncome;
    }
  }

  Iterable<ExpenseManager> applyAll(Iterable<ExpenseManager> expenseManager) {
    return expenseManager.where(apply);
  }
}