import 'package:pos_repository/pos_repository.dart';

enum ContactsViewFilter {all, customerOnly, supplierOnly }

extension ContactsViewFilterX on ContactsViewFilter {
  bool apply(Person contact) {
    switch (this) {
      case ContactsViewFilter.all:
        return true;
      case ContactsViewFilter.customerOnly:
        return contact.isCustomer;
      case ContactsViewFilter.supplierOnly:
        return !contact.isCustomer;
    }
  }

  Iterable<Person> applyAll(Iterable<Person> persons) {
    return persons.where(apply);
  }
}
