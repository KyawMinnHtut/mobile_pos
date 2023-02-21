part of 'transcation_dialog_bloc.dart';

abstract class TransactionDialogEvent extends Equatable {
  const TransactionDialogEvent();

  @override
  List<Object> get props => [];
}

class DialogDescChanged extends TransactionDialogEvent {
  const DialogDescChanged(this.desc);

  final String desc;

  @override
  List<Object> get props => [desc];
}

class DialogAmountChanged extends TransactionDialogEvent {
  const DialogAmountChanged(this.amount);

  final int amount;

  @override
  List<Object> get props => [amount];
}

class DialogRemarkChanged extends TransactionDialogEvent {
  const DialogRemarkChanged(this.remark);

  final String remark;

  @override
  List<Object> get props => [remark];
}


class DialogSubmitted extends TransactionDialogEvent {
  const DialogSubmitted({this.isIncome});

  final bool? isIncome;
}
