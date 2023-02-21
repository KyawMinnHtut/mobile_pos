import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/sale/sale.dart';
import 'package:mobile_pos/sale/view/sales_list.dart';
import 'package:pos_repository/pos_repository.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => InvoicesBloc(posRepository: context.read<PosRepository>())..add(const InvoicesSubscriptionRequested()),
      child: const SalesView(),
    );
  }
}

class SalesView extends StatelessWidget {
  const SalesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        centerTitle: true,
        actions: const [

        ],
      ),
      body: const SalesInvoiceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/invoice');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


