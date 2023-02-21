import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pos/inventory/inventory.dart';

class InventoryFilterButton extends StatelessWidget {
  const InventoryFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((InventoryBloc bloc) => bloc.state.filter);
    return PopupMenuButton<InventoryFilter>(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        initialValue: activeFilter,
        onSelected: (filter) {
          context.read<InventoryBloc>().add(InventoryFilterChanged(filter));
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem(
              value: InventoryFilter.all,
              child: Text('All'),
            ),
          ];
        },
      icon: const Icon(Icons.filter_list_outlined),
        );
  }
}
