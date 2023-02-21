part of 'item_bloc.dart';


abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemNamedChanged extends ItemEvent {
  const ItemNamedChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ItemQtyChanged extends ItemEvent {
  const ItemQtyChanged(this.qty);

  final int qty;

  @override
  List<Object> get props => [qty];
}

class CategoryChanged extends ItemEvent {
  const CategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

class ItemPurchasePriceChanged extends ItemEvent {
  const ItemPurchasePriceChanged(this.purchasePrice);

  final int purchasePrice;

  @override
  List<Object> get props => [purchasePrice];
}

class ItemRetailPriceChanged extends ItemEvent {
  const ItemRetailPriceChanged(this.retailPrice);

  final int retailPrice;

  @override
  List<Object> get props => [retailPrice];
}

class ItemWholeSalePriceChanged extends ItemEvent {
  const ItemWholeSalePriceChanged(this.wholesalePrice);

  final int wholesalePrice;

  @override
  List<Object> get props => [wholesalePrice];
}

class ItemDescChanged extends ItemEvent {
  const ItemDescChanged(this.desc);

  final String desc;

  @override
  List<Object> get props => [desc];
}


class ItemSubmitted extends ItemEvent {
  const ItemSubmitted();
}
