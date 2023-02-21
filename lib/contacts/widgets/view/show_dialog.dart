import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_repository/pos_repository.dart';

import '../bloc/dialog_bloc.dart';

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider<DialogBloc>(
        create: (BuildContext context) => DialogBloc(posReopository: context.read<PosRepository>(), initialPerson: null),
        child: BlocListener<DialogBloc, DialogState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == DialogStatus.success,
          listener: (context, state) {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            title: const Text('Contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _NameField(),
                _PhoneNumberField(),
                _AddressField(),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Save'),
                onPressed: () {
                  context.read<DialogBloc>().add(const DialogSubmitted());
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DialogBloc>().state;
    final hintText = state.initialPerson?.name ?? '';

    return TextFormField(
      key: const Key('editTodoView_title_textFormField'),
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
      key: const Key('editTodoView_title_textFormField'),
      initialValue: state.name,
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
      key: const Key('editTodoView_title_textFormField'),
      initialValue: state.name,
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
