part of 'tab_cubit.dart';

enum ContactsTab{customer, supplier}

class TabState extends Equatable {
  const TabState({
    this.tab = ContactsTab.customer,
});

  final ContactsTab tab;

  @override
  List<Object?> get props => [tab];
}
