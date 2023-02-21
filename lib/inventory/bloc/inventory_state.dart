part of 'inventory_bloc.dart';

enum InventoryStatus { initial, loading, success, failure }

class InventoryState extends Equatable {
  const InventoryState(
      {this.status = InventoryStatus.initial,
      this.items = const [],
      this.filter = InventoryFilter.all,
      this.lastDeletedItem});

  final InventoryStatus status;
  final List<Item> items;
  final InventoryFilter filter;
  final Item? lastDeletedItem;

  Iterable<Item> get filteredItems => filter.applyAll(items);

  InventoryState copyWith({
    InventoryStatus Function()? status,
    List<Item> Function()? items,
    InventoryFilter Function()? filter,
    Item? Function()? lastDeletedItem,
  }) {
    return InventoryState(
      status: status != null ? status() : this.status,
      items: items != null ? items() : this.items,
      filter: filter != null ? filter() : this.filter,
      lastDeletedItem:
          lastDeletedItem != null ? lastDeletedItem() : this.lastDeletedItem,
    );
  }

  @override
  List<Object?> get props => [status, items, filter, lastDeletedItem];
}
