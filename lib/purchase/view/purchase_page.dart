import 'package:flutter/material.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: const PurchaseInvoiceView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/invoice');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PurchaseInvoiceView extends StatelessWidget {
  const PurchaseInvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(columns: const [
          DataColumn(label: Expanded(child: Text('No.'))),
          DataColumn(label: Expanded(child: Text('Date'))),
          DataColumn(label: Expanded(child: Text('Supplier Name'))),
          DataColumn(label: Expanded(child: Text('Amount')))
        ], rows: const [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('26.12.2022')),
            DataCell(Text('Kyaw Kyaw')),
            DataCell(Text('250,000'))
          ])
        ]),
      ),
    );
  }
}
