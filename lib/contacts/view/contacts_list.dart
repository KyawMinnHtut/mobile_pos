import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/contacts/contacts.dart';
import 'package:pos_repository/pos_repository.dart';

import '../widgets/view/edit_contact.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactsBloc, ContactsState>(
      listenWhen: (previous, current) =>
          previous.deletedPerson != current.deletedPerson &&
          current.deletedPerson != null,
      listener: (context, state) {
        final deletedPerson = state.deletedPerson!;
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("${deletedPerson.name} is deleted"),
              // action: SnackBarAction(
              //   label: 'undo',
              //   onPressed: () {
              //     messenger.hideCurrentSnackBar();
              //     context
              //         .read<ContactsBloc>()
              //         .add(const ContactUndoDeletionRequested());
              //   },
              // ),
            ),
          );
      },
      child:
          BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
        if (state.persons.isEmpty) {
          if (state.status == ContactsStatus.loading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state.status != ContactsStatus.success) {
            return const SizedBox();
          } else {
            return const Center(
              child: Text("There is no contacts"),
            );
          }
        }
        return ListView(
          children: [
            for (final person in state.filteredContacts)
              ContactListTile(
                person: person,
                onDelete: () =>
                    context.read<ContactsBloc>().add(ContactDeleted(person)),
                onTap: () => Navigator.of(context)
                    .push(EditContactPage.route(initialPerson: person)),
              )
          ],
        );
      }),
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile(
      {Key? key, required this.person, this.onDelete, this.onTap})
      : super(key: key);

  final Person person;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Text(person.name),
      subtitle: Text(person.address),
      title: Text(person.phNumber),
      minLeadingWidth: 70,
      trailing: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
    );
  }
}
