part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object?> get props => [];
}

class InventorySubscriptionRequested extends InventoryEvent {
  const InventorySubscriptionRequested();
}

class InventoryDeleted extends InventoryEvent {
  final Item item;

  const InventoryDeleted(this.item);

  @override
  List<Object?> get props => [item];
}

class InventoryFilterChanged extends InventoryEvent {
  final InventoryFilter filter;
  const InventoryFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}
