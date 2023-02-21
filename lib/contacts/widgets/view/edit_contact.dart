import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/contacts/widgets/bloc/dialog_bloc.dart';
import 'package:pos_repository/pos_repository.dart';

class EditContactPage extends StatelessWidget {
  const EditContactPage({Key? key}) : super(key: key);

  static Route<void> route({Person? initialPerson}) {
    return MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => DialogBloc(
                  posReopository: context.read<PosRepository>(),
                  initialPerson: initialPerson),
              child: const EditContactPage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DialogBloc, DialogState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == DialogStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditContactView(),
    );
  }
}

class EditContactView extends StatelessWidget {
  const EditContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isNewContact =
        context.select((DialogBloc bloc) => bloc.state.isNewPerson);
    final status = context.select((DialogBloc bloc) => bloc.state.status);
    return Scaffold(
      appBar: AppBar(
        title: isNewContact
            ? const Text("Add Contact")
            : const Text("Edit Contact"),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                _NameField(),
                _PhoneNumberField(),
                _AddressField(),
                _SupplierField(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<DialogBloc>().add(const DialogSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DialogBloc>().state;
    final hintText = state.initialPerson?.name ?? '';

    return TextFormField(
      key: const Key('editContact_name_textFormField'),
      initialValue: state.name,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Name',
        hintText: hintText,
      ),
      // maxLength: 50,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(50),
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      // ],
      onChanged: (value) {
        context.read<DialogBloc>().add(DialogNameChanged(value));
      },
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DialogBloc>().state;
    final hintText = state.initialPerson?.phNumber ?? '';

    return TextFormField(
      keyboardType: TextInputType.number,
      key: const Key('editContact_phNumber_textFormField'),
      initialValue: state.phNumber,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Phone Number',
        hintText: hintText,
      ),
      // maxLength: 11,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(50),
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      // ],
      onChanged: (value) {
        context.read<DialogBloc>().add(DialogPhNumberChanged(value));
      },
    );
  }
}

class _AddressField extends StatelessWidget {
  const _AddressField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DialogBloc>().state;
    final hintText = state.initialPerson?.address ?? '';

    return TextFormField(
      key: const Key('editContact_address_textFormField'),
      initialValue: state.address,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Address',
        hintText: hintText,
      ),
      // maxLength: 50,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(50),
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      // ],
      onChanged: (value) {
        context.read<DialogBloc>().add(DialogAddressChanged(value));
      },
    );
  }
}

// class _SupplierField extends StatefulWidget {
//   const _SupplierField();
//
//   @override
//   State<_SupplierField> createState() => _SupplierFieldState();
// }
//
// class _SupplierFieldState extends State<_SupplierField> {
//   // const _SupplierField({required this.onToggleCompleted});
//   bool isSupplier = false;
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<DialogBloc>().state;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Checkbox(
//               value: state.isCustomer == true ? false : true,
//               onChanged: (value) {
//                 setState(() {
//                   isSupplier = value!;
//                 });
//                 context.read<DialogBloc>().add(DialogIsSupplierAsked(isSupplier: value!));},
//               // onChanged: onToggleCompleted == null
//               //     ? null
//               //     : (value) => onToggleCompleted!(value!)
//           ),
//           const Text("Supplier"),
//         ],
//       ),
//     );
//   }
// }

class _SupplierField extends StatelessWidget {
  const _SupplierField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DialogBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            value: state.isCustomer == true ? false : true,
            onChanged: (value) {
              context.read<DialogBloc>().add(DialogIsSupplierAsked(isSupplier: value!));},
          ),
          const Text("Supplier"),
        ],
      ),
    );
  }
}

