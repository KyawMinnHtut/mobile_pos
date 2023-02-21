part of 'contacts_bloc.dart';

enum ContactsStatus { initial, loading, success, failure }

class ContactsState extends Equatable {
  const ContactsState({
    this.status = ContactsStatus.initial,
    this.persons = const [],
    this.filter = ContactsViewFilter.all,
    this.deletedPerson,
  });

  final ContactsStatus status;
  final List<Person> persons;
  final ContactsViewFilter filter;
  final Person? deletedPerson;

  Iterable<Person> get filteredContacts => filter.applyAll(persons);

  ContactsState copyWith({
    ContactsStatus Function()? status,
    List<Person> Function()? persons,
    ContactsViewFilter Function()? filter,
    Person? Function()? deletedPerson,
  }) {
    return ContactsState(
      status: status != null ? status() : this.status,
      persons: persons != null ? persons() : this.persons,
      filter: filter != null ? filter() : this.filter,
      deletedPerson:
          deletedPerson != null ? deletedPerson() : this.deletedPerson,
    );
  }

  @override
  List<Object?> get props => [
        status,
        persons,
        filter,
        deletedPerson,
      ];
}
