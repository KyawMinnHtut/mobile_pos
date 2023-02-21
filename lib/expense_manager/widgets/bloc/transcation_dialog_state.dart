part of 'transcation_dialog_bloc.dart';

enum TransactionDialogStatus { initial, loading, success, failure }

extension DialogStatusX on TransactionDialogStatus {
  bool get isLoadingOrSuccess => [
        TransactionDialogStatus.loading,
        TransactionDialogStatus.success,
      ].contains(this);
}

class TransactionDialogState extends Equatable {
  const TransactionDialogState({
    this.status = TransactionDialogStatus.initial,
    this.initialTransaction,
    this.desc = '',
    this.amount = 0,
    this.remark = '',
    this.isIncome = true,
  });

  final TransactionDialogStatus status;
  final ExpenseManager? initialTransaction;
  final String desc;
  final int amount;
  final String remark;
  final bool isIncome;

  bool get isNewTransaction => initialTransaction == null;

  TransactionDialogState copyWith({
    TransactionDialogStatus? status,
    ExpenseManager? initialTransaction,
    String? desc,
    int? amount,
    String? remark,
    bool? isIncome,
  }) {
    return TransactionDialogState(
      status: status ?? this.status,
      initialTransaction: initialTransaction ?? this.initialTransaction,
      desc: desc ?? this.desc,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  @override
  List<Object?> get props =>
      [status, initialTransaction, desc, amount, remark, isIncome];
}
