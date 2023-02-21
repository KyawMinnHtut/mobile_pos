import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../sale.dart';

class SalesInvoiceList extends StatelessWidget {
  const SalesInvoiceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: BlocBuilder<InvoicesBloc, InvoicesState>(
          builder: (context, state) {
            if (state.invoices.isEmpty) {
              if (state.status == InvoicesStatus.loading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state.status != InvoicesStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text("There is no sale."),
                );
              }
            }
            return DataTable(
              columns: const [
                DataColumn(label: Expanded(child: Text('No.'))),
                DataColumn(label: Expanded(child: Text('Date'))),
                DataColumn(label: Expanded(child: Text('Customer Name'))),
                DataColumn(label: Expanded(child: Text('Amount')))
              ],
              rows:
                List<DataRow>.generate(state.filteredInvoices.length, (index) => DataRow(cells: [
                  DataCell(Text('${index + 1}')),
                  DataCell(Text(DateFormat.yMMMMd().format(state.filteredInvoices.toList()[index].dateRecorded.toLocal()))),
                  DataCell(Text(state.filteredInvoices.toList()[index].person.toString())),
                  DataCell(Text(state.filteredInvoices.toList()[index].totalAmount.toString()))]
                ))
                // for (final invoice in state.filteredInvoices)
                //   DataRow(cells: [
                //     DataCell(Text(invoice.id.toString())),
                //     DataCell(Text(invoice.dateRecorded.toString())),
                //     DataCell(Text(invoice.personId.toString())),
                //     DataCell(Text(invoice.totalAmount.toString()))
                //   ])
              // rows: List<DataRow>.generate(
              //     list.length,
              //         (index) =>InvoicesStatus
              //         DataRow(cells: [
              //           DataCell(Text("${index + 1}")),
              //           DataCell(Text(list[index]['date'])),
              //           DataCell(Text(list[index]['name'])),
              //           DataCell(Text(list[index]['amount'])),
              //         ])),
            );
          },
        ),
      ),
    );
  }
}
