
import 'package:pos_repository/pos_repository.dart';

enum InventoryFilter {all}

extension InventoryFilterX on InventoryFilter {
  bool apply(Item item) {
    switch (this) {
      case InventoryFilter.all:
        return true;
    }
  }

  Iterable<Item> applyAll(Iterable<Item> items) {
    return items.where(apply);
  }
}