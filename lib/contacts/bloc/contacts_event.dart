part of 'contacts_bloc.dart';


abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class ContactsSubscriptionRequested extends ContactsEvent {
  const ContactsSubscriptionRequested();
}

class ContactDeleted extends ContactsEvent {
  const ContactDeleted(this.contact);

  final Person contact;

  @override
  List<Object> get props => [contact];
}

class ContactUndoDeletionRequested extends ContactsEvent {
  const ContactUndoDeletionRequested();
}

class ContactsFilterChanged extends ContactsEvent {
  final ContactsViewFilter filter;

  const ContactsFilterChanged(this.filter);
}