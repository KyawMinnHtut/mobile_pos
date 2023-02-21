part of 'dialog_bloc.dart';

enum DialogStatus { initial, loading, success, failure }

extension DialogStatusX on DialogStatus {
  bool get isLoadingOrSuccess => [
    DialogStatus.loading,
    DialogStatus.success,
  ].contains(this);
}

class DialogState extends Equatable {
  const DialogState({
    this.status = DialogStatus.initial,
    this.initialPerson,
    this.name = '',
    this.phNumber = '',
    this.address = '',
    this.isCustomer = true,
  });

  final DialogStatus status;
  final Person? initialPerson;
  final String name;
  final String phNumber;
  final String address;
  final bool isCustomer;

  bool get isNewPerson => initialPerson == null;

  DialogState copyWith({
    DialogStatus? status,
    Person? initialPerson,
    String? name,
    String? phNumber,
    String? address,
    bool? isCustomer,
  }) {
    return DialogState(
      status: status ?? this.status,
      initialPerson: initialPerson ?? this.initialPerson,
      name: name ?? this.name,
      phNumber: phNumber ?? this.phNumber,
      address: address ?? this.address,
      isCustomer: isCustomer ?? this.isCustomer,
    );
  }

  @override
  List<Object?> get props => [status, initialPerson, name, phNumber, address, isCustomer];
}

