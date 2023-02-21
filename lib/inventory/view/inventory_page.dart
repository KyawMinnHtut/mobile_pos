import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/inventory/inventory.dart';
import 'package:pos_repository/pos_repository.dart';

import '../../item/item.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: const InventoryView(),
        create: (context) =>
            InventoryBloc(posRepository: context.read<PosRepository>())..add(const InventorySubscriptionRequested()));
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        centerTitle: true,
        actions: [
          const InventoryFilterButton(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: BlocListener<InventoryBloc, InventoryState>(
        child: BlocBuilder<InventoryBloc, InventoryState>(
            builder: (context, state) {
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
            children: [for (final item in state.filteredItems)
              ItemListTile(
                item: item,
                onDismissed: (_){
                  context.read<InventoryBloc>().add(InventoryDeleted(item));
                },
                onTap: (){
                  Navigator.of(context).push(ItemPage.route(initialItem: item));
                },
              )],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(ItemPage.route());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemListTile extends StatelessWidget {
  const ItemListTile(
      {Key? key, required this.item, this.onDismissed, this.onTap})
      : super(key: key);

  final Item item;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
        key: UniqueKey(),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          color: theme.colorScheme.error,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Icon(
            Icons.delete,
            color: Color(0xAAFFFFFF),
          ),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Text(item.quantity.toString()),
        ));
  }
}
