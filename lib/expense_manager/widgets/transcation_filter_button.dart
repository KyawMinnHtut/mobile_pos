import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_manager_bloc.dart';
import '../models/models.dart';

class TransactionsFilterButton extends StatelessWidget {
  const TransactionsFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
    context.select((ExpenseManagerBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TranscationsViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      onSelected: (filter) {
        context
            .read<ExpenseManagerBloc>()
            .add(ExpenseManagerFilterChanged(filter));
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: TranscationsViewFilter.all,
            child: Text("All"),
          ),
          PopupMenuItem(
            value: TranscationsViewFilter.income,
            child: Text("Income"),
          ),
          PopupMenuItem(
            value: TranscationsViewFilter.expense,
            child: Text("Expense"),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}