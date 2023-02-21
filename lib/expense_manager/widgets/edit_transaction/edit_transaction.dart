import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_repository/pos_repository.dart';

import '../widgets.dart';

class EditTransactionPage extends StatelessWidget {
  const EditTransactionPage({Key? key, required this.isIncome}) : super(key: key);

  final bool isIncome;

  static Route<void> route({ExpenseManager? initialTransaction, required isIncome}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => TransactionDialogBloc(
          posRepository: context.read<PosRepository>(),
          initialTransaction: initialTransaction,
        ),
        child: EditTransactionPage(isIncome: isIncome,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionDialogBloc, TransactionDialogState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          current.status == TransactionDialogStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: EditTransactionView(isIncome: isIncome,),
    );
  }
}

class EditTransactionView extends StatelessWidget {
  const EditTransactionView({Key? key, required this.isIncome}) : super(key: key);

  final bool isIncome;

  @override
  Widget build(BuildContext context) {
    final status = context.select((TransactionDialogBloc bloc) => bloc.state.status);
    // final isNewTodo = context.select(
    //       (TransactionDialogBloc bloc) => bloc.state.isNewTransaction,
    // );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;
    return Scaffold(
      appBar: AppBar(
        title: Text(isIncome ? 'Income' : 'Expense'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _DescField(),
              _AmountField(),
              _RemarkField(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<TransactionDialogBloc>().add(DialogSubmitted(isIncome: isIncome)),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}

// Future<void> _dialogBuilder(BuildContext context, bool isIncome,
//     {ExpenseManager? initialTransaction}) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return BlocProvider(
//         create: (context) => TransactionDialogBloc(
//             posRepository: context.read<PosRepository>(),
//             initialTransaction: initialTransaction),
//         child: AlertDialog(
//           title: Text(
//             isIncome ? 'Income' : 'Expense',
//             textAlign: TextAlign.center,
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               _DescField(),
//               _AmountField(),
//               _RemarkField(),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             SaveButton(isIncome: isIncome),
//             // TextButton(
//             //   style: TextButton.styleFrom(
//             //     textStyle: Theme.of(context).textTheme.labelLarge,
//             //   ),
//             //   onPressed: context
//             //           .select((TransactionDialogBloc bloc) => bloc.state.status)
//             //           .isLoadingOrSuccess
//             //       ? null
//             //       : () {
//             //           context
//             //               .read<TransactionDialogBloc>()
//             //               .add(DialogSubmitted(isIncome));
//             //           Navigator.of(context).pop();
//             //         },
//             //   child: const Text('Save'),
//             // ),
//           ],
//         ),
//       );
//     },
//   );
// }
//
// class SaveButton extends StatelessWidget {
//   const SaveButton({Key? key, required this.isIncome}) : super(key: key);
//
//   final bool isIncome;
//
//   @override
//   Widget build(BuildContext context) {
//     final status =
//         context.select((TransactionDialogBloc bloc) => bloc.state.status);
//     // final isNewTransaction = context.select(
//     //   (TransactionDialogBloc bloc) => bloc.state.isNewTransaction,
//     // );
//     return TextButton(
//       style: TextButton.styleFrom(
//         textStyle: Theme.of(context).textTheme.labelLarge,
//       ),
//       onPressed: status.isLoadingOrSuccess
//           ? null
//           : () {
//               context
//                   .read<TransactionDialogBloc>()
//                   .add(DialogSubmitted(isIncome));
//               Navigator.of(context).pop();
//             },
//       child: const Text('Save'),
//     );
//   }
// }

class _DescField extends StatelessWidget {
  const _DescField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransactionDialogBloc>().state;
    final hintText = state.initialTransaction?.description ?? '';

    return TextFormField(
      key: const Key('transaction_desc_textFormField'),
      initialValue: state.desc,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Description',
        hintText: hintText,
      ),
      onChanged: (value) {
        context.read<TransactionDialogBloc>().add(DialogDescChanged(value));
      },
    );
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransactionDialogBloc>().state;
    final hintText = state.initialTransaction?.amount ?? '';

    return TextFormField(
      key: const Key('transaction_amount_textFormField'),
      initialValue: state.amount == 0 ? '' : state.amount.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Amount',
        hintText: hintText.toString(),
      ),
      onChanged: (value) {
        context
            .read<TransactionDialogBloc>()
            .add(DialogAmountChanged(int.parse(value)));
      },
    );
  }
}

class _RemarkField extends StatelessWidget {
  const _RemarkField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransactionDialogBloc>().state;
    final hintText = state.initialTransaction?.remark ?? '';

    return TextFormField(
      key: const Key('transaction_remark_textFormField'),
      initialValue: state.remark,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Remark',
        hintText: hintText,
      ),
      onChanged: (value) {
        context.read<TransactionDialogBloc>().add(DialogRemarkChanged(value));
      },
    );
  }
}
