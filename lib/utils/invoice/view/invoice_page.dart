import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/inventory/inventory.dart';
import 'package:pos_repository/pos_repository.dart';
import 'package:badges/badges.dart';

import '../invoice.dart';
import '../sale_item_bloc/sale_item_bloc.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InventoryBloc>(
          create: (context) =>
              InventoryBloc(posRepository: context.read<PosRepository>())
                ..add(const InventorySubscriptionRequested())),
      BlocProvider<SaleBloc>(create: (context) => SaleBloc(posRepository: context.read<PosRepository>())..add(const SaleListRequested())),
    ], child: const InvoiceView());
    // return BlocProvider(
    //   create: (context) =>
    //       InventoryBloc(posRepository: context.read<PosRepository>())
    //         ..add(const InventorySubscriptionRequested()),
    //   child: const InvoiceView(),
    // );
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       actions: [
    //         ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.save), label: const Text('Save')),
    //       ],
    //       title: const Text('Invoice'),
    //       centerTitle: true,
    //     ),
    //     body: Stack(
    //       children: [
    //         InventoryList(),
    //         DraggableScrollableSheet(
    //           initialChildSize: 0.25,
    //           builder:
    //               (BuildContext context, ScrollController scrollController) =>
    //                   SingleChildScrollView(
    //                     controller: scrollController,
    //                     child: Stack(
    //                       alignment: AlignmentDirectional.topCenter,
    //                       clipBehavior: Clip.none,
    //                       children: [
    //                         Positioned(
    //                           top: -15,
    //                             child: Container(
    //                           width: 61,
    //                           height: 7,
    //                           color: Colors.blue,
    //                         )),
    //                         ClipRRect(
    //                           borderRadius: BorderRadius.circular(12),
    //                           child: Container(
    //                             color: Colors.blue[100],
    //                             child: Column(
    //                               children: [
    //                                 ItemTable(),
    //                                 ElevatedButton(
    //                                     onPressed: () {
    //                                       Navigator.pushReplacementNamed(
    //                                           context, '/checkout');
    //                                     },
    //                                     child: const Text('Checkout'))
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class InvoiceView extends StatelessWidget {
  const InvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: true,
        actions: [
          // const InventoryFilterButton(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: const ItemList(),
      floatingActionButton: BlocBuilder<SaleBloc, SaleState>(
  builder: (context, state) {
    if (state.sales.isEmpty) {
      return FloatingActionButton(
        onPressed: () {
          // _showModalBottomSheet(context);
          // Navigator.of(context).push(ItemPage.route());
        },
        child: const Icon(Icons.shopping_cart),
      );
    }
      return Badge(
        badgeContent: Text(state.sales.length.toString()),
        badgeColor: Colors.green,
        child: FloatingActionButton(
          onPressed: () {
            _showModalBottomSheet(context);
            // Navigator.of(context).push(ItemPage.route());
          },
          child: const Icon(Icons.shopping_cart),
        ),
      );
  },
),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          minChildSize: 0.25,
          maxChildSize: 0.9,
          builder: (context, controller) => SingleChildScrollView(
            controller: controller,
            child: const BottomList(),
          ),
        );
      });
}

class BottomList extends StatelessWidget {
  const BottomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => SaleBloc(posRepository: context.read<PosRepository>())..add(const SaleListRequested()),
),
    BlocProvider(
      create: (context) => SaleItemBloc(posRepository: context.read<PosRepository>()),
    ),
  ],
  child: Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          // top: -15,
          child: Container(
            width: 61,
            height: 7,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
          ),
        ),
        const ItemTable(),
      ],
    ),
);
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryBloc, InventoryState>(
      child:
          BlocBuilder<InventoryBloc, InventoryState>(builder: (context, state) {
        if (state.items.isEmpty) {
          if (state.status == InventoryStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status != InventoryStatus.success) {
            return const SizedBox();
          } else {
            return Center(
              child: Text(
                'There is no items.',
                style: Theme.of(context).textTheme.caption,
              ),
            );
          }
        }
        return CupertinoScrollbar(
            child: ListView(
          children: [
            for (final item in state.filteredItems)
              ListTile(
                title: Text(item.name),
                subtitle: Text(item.description),
                trailing: Text(item.quantity.toString()),
                onTap: () => context.read<PosRepository>().saveSale(item: item),
              )
            // ItemListTile(
            //   item: item,
            // onDismissed: (_) {
            //   context.read<InventoryBloc>().add(InventoryDeleted(item));
            // },
            //   onTap: () {
            // Navigator.of(context).push(ItemPage.route(initialItem: item));
            //   },
            // )
          ],
        ));
      }),
      listenWhen: (previous, current) =>
          previous.lastDeletedItem != current.lastDeletedItem &&
          current.lastDeletedItem != null,
      listener: (context, state) {
        final deletedItem = state.lastDeletedItem;
        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
              SnackBar(content: Text('${deletedItem?.name} is deleted')));
      },
    );
  }
}

class ItemTable extends StatelessWidget {
  const ItemTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(
      builder: (context, state) {
        if (state.sales.isEmpty) {
          if (state.status == InventoryStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status != InventoryStatus.success) {
            return const SizedBox();
          } else {
            return Center(
              child: Text(
                'There is no items.',
                style: Theme.of(context).textTheme.caption,
              ),
            );
          }
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(columns: const [
                DataColumn(
                    label: Expanded(
                  child: Text('Item'),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text('Price'),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text('Qty'),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text('Amount'),
                )),
                DataColumn(label: Expanded(child: Text('')))
              ], rows: [
                for (final sale in state.sales)
                  DataRow(cells: [
                    DataCell(Text(sale.item)),
                    DataCell(Text(sale.itemPrice.toString())),
                    DataCell(Text(sale.itemQuantity.toString())),
                    // DataCell(Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //   IconButton(onPressed: (){
                    //     context.read<SaleItemBloc>().add(SaleItemQtyDecreased(sale.itemQuantity));
                    //   }, icon: const Icon(Icons.remove)),
                    //   Text(sale.itemQuantity.toString()),
                    //   IconButton(onPressed: (){
                    //     context.read<SaleItemBloc>().add(SaleItemQtyIncreased(sale.itemQuantity));
                    //   }, icon: const Icon(Icons.add)),
                    // ],)),
                     DataCell(Text((sale.itemPrice * sale.itemQuantity).toString())),
                    DataCell(IconButton(
                        onPressed: () {
                          context.read<SaleBloc>().add(SaleItemDeleted(sale));
                        }, icon: const Icon(Icons.delete_forever))),
                  ]),
              ]),
              if (state.sales.isNotEmpty) ElevatedButton(onPressed: () {}, child: const Text('Checkout'))
            ],
          ),
        );
      },
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
            child: TextFormField(
                decoration: const InputDecoration(
          icon: Icon(Icons.production_quantity_limits),
          labelText: 'Item',
        ))),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class InventoryList extends StatelessWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Text('Name'),
          title: Text('Category'),
          subtitle: Text("Description"),
          trailing: Text('Quantity'),
          dense: true,
        )
      ],
    );
  }
}
