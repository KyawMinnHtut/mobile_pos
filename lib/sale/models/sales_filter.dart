import 'package:pos_repository/pos_repository.dart';

enum InvoicesViewFilter {all }

extension SalesViewFilterX on InvoicesViewFilter {
  bool apply(Invoice invoice) {
    switch (this) {
      case InvoicesViewFilter.all:
        return true;
      // case SalesViewFilter.customerOnly:
      //   return contact.isCustomer;
      // case SalesViewFilter.supplierOnly:
      //   return !contact.isCustomer;
    }
  }

  Iterable<Invoice> applyAll(Iterable<Invoice> invoices) {
    return invoices.where(apply);
  }
}