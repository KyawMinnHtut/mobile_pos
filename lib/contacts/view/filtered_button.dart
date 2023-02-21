import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contacts_bloc.dart';
import '../model/contacts_view_filter.dart';


class ContactsFilterButton extends StatelessWidget {
  const ContactsFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
    context.select((ContactsBloc bloc) => bloc.state.filter);

    return PopupMenuButton<ContactsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      onSelected: (filter) {
        context
            .read<ContactsBloc>()
            .add(ContactsFilterChanged(filter));
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: ContactsViewFilter.all,
            child: Text("All"),
          ),
          PopupMenuItem(
            value: ContactsViewFilter.customerOnly,
            child: Text("Customer"),
          ),
          PopupMenuItem(
            value: ContactsViewFilter.supplierOnly,
            child: Text("Supplier"),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
