part of 'temp_bloc.dart';

enum TempStatus {initial, loading, success, failure}

class TempState extends Equatable {
  const TempState({this.status = TempStatus.initial, this.items = const [], this.lastDeletedItem,});
  final TempStatus status;
  final List<Item> items;
  final Item? lastDeletedItem;

  TempState copyWith({
  TempStatus Function()? status,
    List<Item> Function()? items,
    Item Function()? lastDeletedItem,
}) {
    return TempState(
      status: status != null ? status() : this.status,
      items: items != null ? items() : this.items,
      lastDeletedItem: lastDeletedItem != null ? lastDeletedItem() : this.lastDeletedItem,
    );
  }

  @override
  List<Object?> get props => [status, items, lastDeletedItem];

}

