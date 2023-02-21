part of 'item_bloc.dart';

enum ItemStatus { initial, loading, success, failure }

extension ItemStatusX on ItemStatus {
  bool get isLoadingOrSuccess => [
        ItemStatus.loading,
        ItemStatus.success,
      ].contains(this);
}

class ItemState extends Equatable {
  const ItemState({
    this.status = ItemStatus.initial,
    this.category,
    this.initialItem ,
    this.name = '',
    this.qty = 0,
    this.purchasePrice = 0,
    this.retailPrice = 0,
    this.wholesalePrice = 0,
    this.desc = '',
  });

  final ItemStatus status;
  final Item? initialItem;
  final String name;
  final int qty;

  final String? category;
  final int purchasePrice;
  final int retailPrice;
  final int wholesalePrice;
  final String desc;

  bool get isNewItem => initialItem == null;

  ItemState copyWith({
    ItemStatus? status,
    Item? initialItem,
    String? name,
    int? qty,
    int? categoryId,
    String? category,
    int? purchasePrice,
    int? retailPrice,
    int? wholesalePrice,
    String? desc,
  }) {
    return ItemState(
      status: status ?? this.status,
      initialItem: initialItem ?? this.initialItem,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      desc: desc ?? this.desc,
      category: category ?? this.category,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      retailPrice: retailPrice ?? this.retailPrice,
      wholesalePrice: wholesalePrice ?? this.wholesalePrice,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialItem,
        name,
        category,
        qty,
        purchasePrice,
        retailPrice,
        wholesalePrice,
        desc,
      ];
}
