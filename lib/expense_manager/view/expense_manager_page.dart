import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobile_pos/expense_manager/bloc/expense_manager_bloc.dart';
import 'package:pos_repository/pos_repository.dart';

import '../widgets/edit_transaction/edit_transaction.dart';
import '../widgets/widgets.dart';

class ExpenseManagerPage extends StatelessWidget {
  const ExpenseManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExpenseManagerBloc(posReopository: context.read<PosRepository>())
            ..add(const ExpManagerSubscriptionRequested()),
      child: const ExpenseManagerView(),
    );
  }
}

class ExpenseManagerView extends StatelessWidget {
  const ExpenseManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
        centerTitle: true,
        actions: const [
          TransactionsFilterButton(),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: const TransactionsList(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        overlayOpacity: 0,
        spacing: 7,
        spaceBetweenChildren: 7,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.remove),
            labelBackgroundColor: Colors.black12,
            backgroundColor: Colors.red,
            label: 'Expense',
            onTap: () => Navigator.of(context)
                .push(EditTransactionPage.route(isIncome: false)),
          ),
          SpeedDialChild(
            child: const Icon(Icons.add),
            labelBackgroundColor: Colors.black12,
            backgroundColor: Colors.green,
            label: 'Income',
            onTap: () => Navigator.of(context)
                .push(EditTransactionPage.route(isIncome: true)),
          ),
        ],
      ),
    );
  }
}

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseManagerBloc, ExpenseManagerState>(
      listenWhen: (previous, current) =>
          previous.lastDeletedExpenseManager !=
              current.lastDeletedExpenseManager &&
          current.lastDeletedExpenseManager != null,
      listener: (context, state) {
        final deletedTranscation = state.lastDeletedExpenseManager!;
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text('${deletedTranscation.description} is deleted.')));
      },
      child: BlocBuilder<ExpenseManagerBloc, ExpenseManagerState>(
        builder: (context, state) {
          if (state.expenseManagers.isEmpty) {
            if (state.status == TransactionStatus.loading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state.status != TransactionStatus.success) {
              return const SizedBox();
            } else {
              return const Center(
                child: Text("There is no transaction"),
              );
            }
          }
          return ListView(
            children: [
              for (final transaction in state.filteredTransactions)
                Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).colorScheme.error,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xAAFFFFFF),
                    ),
                  ),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => context
                      .read<ExpenseManagerBloc>()
                      .add(ExpenseManagerDeleted(transaction)),
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(
                        EditTransactionPage.route(
                            isIncome: transaction.isIncome,
                            initialTransaction: transaction)),
                    title: Text(transaction.description.toString()),
                    trailing: Text(
                      transaction.amount.toString(),
                      style: TextStyle(
                          color:
                              transaction.isIncome ? Colors.green : Colors.red),
                    ),
                  ),
                )
            ],
          );
        },
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
//
// class _DescField extends StatelessWidget {
//   const _DescField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<TransactionDialogBloc>().state;
//     final hintText = state.initialTransaction?.description ?? '';
//
//     return TextFormField(
//       key: const Key('transaction_desc_textFormField'),
//       initialValue: state.desc,
//       decoration: InputDecoration(
//         enabled: !state.status.isLoadingOrSuccess,
//         labelText: 'Description',
//         hintText: hintText,
//       ),
//       onChanged: (value) {
//         context.read<TransactionDialogBloc>().add(DialogDescChanged(value));
//       },
//     );
//   }
// }
//
// class _AmountField extends StatelessWidget {
//   const _AmountField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<TransactionDialogBloc>().state;
//     final hintText = state.initialTransaction?.amount ?? '';
//
//     return TextFormField(
//       key: const Key('transaction_amount_textFormField'),
//       initialValue: state.amount == 0 ? '' : state.amount.toString(),
//       decoration: InputDecoration(
//         enabled: !state.status.isLoadingOrSuccess,
//         labelText: 'Amount',
//         hintText: hintText.toString(),
//       ),
//       onChanged: (value) {
//         context
//             .read<TransactionDialogBloc>()
//             .add(DialogAmountChanged(int.parse(value)));
//       },
//     );
//   }
// }
//
// class _RemarkField extends StatelessWidget {
//   const _RemarkField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<TransactionDialogBloc>().state;
//     final hintText = state.initialTransaction?.remark ?? '';
//
//     return TextFormField(
//       key: const Key('transaction_remark_textFormField'),
//       initialValue: state.remark,
//       decoration: InputDecoration(
//         enabled: !state.status.isLoadingOrSuccess,
//         labelText: 'Remark',
//         hintText: hintText,
//       ),
//       onChanged: (value) {
//         context.read<TransactionDialogBloc>().add(DialogRemarkChanged(value));
//       },
//     );
//   }
// }
