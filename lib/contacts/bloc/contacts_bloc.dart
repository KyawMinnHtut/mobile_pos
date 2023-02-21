import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_pos/contacts/contacts.dart';
import 'package:pos_repository/pos_repository.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final PosRepository _posRepository;
  ContactsBloc({required PosRepository posReopository})
      : _posRepository = posReopository,
        super(const ContactsState()) {
    on<ContactsSubscriptionRequested>(_onSubscriptionRequested);
    on<ContactDeleted>(_onPersonDeleted);
    on<ContactsFilterChanged>(_onFilterChanged);
    on<ContactUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  Future<void> _onSubscriptionRequested(
      ContactsSubscriptionRequested event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(status: () => ContactsStatus.loading));
    await emit.forEach<List<Person>>(
        _posRepository.getPersons(),
      onData: (persons) => state.copyWith(
        status: () => ContactsStatus.success,
        persons: () => persons,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ContactsStatus.failure,
      )
    );
  }

  Future<void> _onPersonDeleted(ContactDeleted event, Emitter<ContactsState> emit) async {
    emit(state.copyWith(deletedPerson: () => event.contact));
    await _posRepository.deletePerson(event.contact.name!);
  }

  void _onFilterChanged(ContactsFilterChanged event, Emitter<ContactsState> emit){
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onUndoDeletionRequested(ContactUndoDeletionRequested event, Emitter<ContactsState> emit) async{
    assert(state.deletedPerson != null, 'Deleted person cannot be null');
    final person = state.deletedPerson!;
    emit(state.copyWith(deletedPerson: () => null));
    await _posRepository.savePerson(person);
  }
}
