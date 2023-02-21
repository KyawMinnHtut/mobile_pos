part of 'dialog_bloc.dart';

abstract class DialogEvent extends Equatable {
  const DialogEvent();

  @override
  List<Object> get props => [];
}

class DialogNameChanged extends DialogEvent {
  const DialogNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class DialogPhNumberChanged extends DialogEvent {
  const DialogPhNumberChanged(this.phNumber);

  final String phNumber;

  @override
  List<Object> get props => [phNumber];
}

class DialogAddressChanged extends DialogEvent {
  const DialogAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

class DialogIsSupplierAsked extends DialogEvent {
  const DialogIsSupplierAsked({required this.isSupplier});

  final bool isSupplier;
}

class DialogSubmitted extends DialogEvent {
  const DialogSubmitted();
}

