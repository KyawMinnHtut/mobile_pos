import 'package:pos_repository/pos_repository.dart';

enum SaleViewFilter {all, invoiceNull }

extension SalesViewFilterX on SaleViewFilter {
  bool apply(Sale sale) {
    switch (this) {
      case SaleViewFilter.all:
        return true;
      case SaleViewFilter.invoiceNull:
        return sale.invoiceId == null;
    // case SalesViewFilter.customerOnly:
    //   return contact.isCustomer;
    // case SalesViewFilter.supplierOnly:
    //   return !contact.isCustomer;
    }
  }

  Iterable<Sale> applyAll(Iterable<Sale> sales) {
    return sales.where(apply);
  }
}