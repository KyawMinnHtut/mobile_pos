import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/contacts/contacts.dart';
import 'package:mobile_pos/contacts/widgets/view/edit_contact.dart';
import 'package:pos_repository/pos_repository.dart';

import 'contacts_list.dart';
import 'filtered_button.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(providers: [
      // BlocProvider(create: (BuildContext context) => TabCubit()),
      // BlocProvider(create: (BuildContext context) => DialogBloc(posReopository: context.read<PosReopository>(), initialPerson: null)),
    //   BlocProvider(
    //       create: (BuildContext context) =>
    //           ContactsBloc(posReopository: context.read<PosReopository>())
    //             ..add(const ContactsSubscriptionRequested()))
    // ], child: const ContactsView());
    return BlocProvider(
      create: (_) => ContactsBloc(posReopository: context.read<PosRepository>())..add(const ContactsSubscriptionRequested()),
      child: const ContactsView(),
    );
  }
}

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final selectedTab = context.select((TabCubit cubit) => cubit.state.tab);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        actions: const [
          ContactsFilterButton(),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: const ContactsList(),
      // body: IndexedStack(
      //   index: selectedTab.index,
      //   children: const [
      //     ContactsList(isCustomer: true),
      //     ContactsList(isCustomer: false)
      //   ],
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       _TabButton(
      //         groupValue: selectedTab,
      //         value: ContactsTab.customer,
      //         text: const Text("Customer"),
      //       ),
      //       _TabButton(
      //         groupValue: selectedTab,
      //         value: ContactsTab.supplier,
      //         text: const Text("Supplier"),
      //       ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Customer'),
      //     BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Supplier'),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // dialogBuilder(context);
          Navigator.of(context).push(EditContactPage.route());

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class _TabButton extends StatelessWidget {
//   const _TabButton({
//     required this.groupValue,
//     required this.value,
//     required this.text,
//   });
//
//   final ContactsTab groupValue;
//   final ContactsTab value;
//   final Widget text;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => context.read<TabCubit>().setTab(value),
//       // iconSize: 32,
//       // color:
//       // groupValue != value ? null : Theme.of(context).colorScheme.secondary,
//       child: text,
//     );
//   }
// }
