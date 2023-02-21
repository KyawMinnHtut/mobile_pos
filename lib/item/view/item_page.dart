import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_repository/pos_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../category/category.dart';
import '../item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key}) : super(key: key);

  static Route<void> route({Item? initialItem}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => ItemBloc(
          posRepository: context.read<PosRepository>(),
          initialItem: initialItem,
        ),
        child: const ItemPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == ItemStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const ItemView(),
    );
  }
}

class ItemView extends StatelessWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((ItemBloc bloc) => bloc.state.status);
    final isNewItem = context.select(
      (ItemBloc bloc) => bloc.state.isNewItem,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewItem ? 'Add Item' : 'Edit Item'),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                _NameField(),
                _QtyField(),
                _CategoryField(),
                _PurchasePriceField(),
                _RetailPriceField(),
                _WholeSalePriceField(),
                _DescField()
              ],
            ),
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
            : () => context.read<ItemBloc>().add(const ItemSubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.name ?? '';
    return TextFormField(
      key: const Key('item_name_field'),
      initialValue: state.name,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Name',
        hintText: hintText,
      ),
      onChanged: (value) =>
          context.read<ItemBloc>().add(ItemNamedChanged(value)),
    );
  }
}

class _QtyField extends StatelessWidget {
  const _QtyField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.quantity ?? '';
    return TextFormField(
      key: const Key('item_qty_field'),
      initialValue: state.qty == 0 ? '' : state.qty.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Quantity',
        hintText: hintText.toString(),
      ),
      onChanged: (value) =>
          context.read<ItemBloc>().add(ItemQtyChanged(int.parse(value))),
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.category ?? '';
    final isNewItem = context.select((ItemBloc bloc) => bloc.state.isNewItem);
    // final items = context.read<PosRepository>().getCategoriesForItem().then((value) => value.map((e) => e.name).toList());
    // final Category selectedItem = items
    //     .then(
    //         (value) => value.where((element) => element.id == state.categoryId))
    //     .then((value) => value.first) as Category;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Flexible(
            child: DropdownSearch<String>(
              key: const Key('category_dropdown_id'),
              asyncItems: (String s) => context.read<PosRepository>().getCategoriesForItem().then((value) => value.map((e) => e.name).toList()),
              selectedItem: isNewItem ? null : state.category,
              onChanged: (value) =>
                  context.read<ItemBloc>().add(CategoryChanged(value!)),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                labelText: 'Category',
                hintText: hintText,
              )),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(CategoryItem.route());
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

// Category _selectedItem(BuildContext context, int id) {
//   return context.read<PosRepository>().getCategoryById(id);
// }

class _PurchasePriceField extends StatelessWidget {
  const _PurchasePriceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.purchasePrice ?? '';
    return TextFormField(
      key: const Key('item_p_field'),
      initialValue:
          state.purchasePrice == 0 ? '' : state.purchasePrice.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Purchase Price',
        hintText: hintText.toString(),
      ),
      onChanged: (value) => context
          .read<ItemBloc>()
          .add(ItemPurchasePriceChanged(int.parse(value))),
    );
  }
}

class _RetailPriceField extends StatelessWidget {
  const _RetailPriceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.retailPrice ?? '';
    return TextFormField(
      key: const Key('item_r_field'),
      initialValue: state.retailPrice == 0 ? '' : state.retailPrice.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Retail Price',
        hintText: hintText.toString(),
      ),
      onChanged: (value) => context
          .read<ItemBloc>()
          .add(ItemRetailPriceChanged(int.parse(value))),
    );
  }
}

class _WholeSalePriceField extends StatelessWidget {
  const _WholeSalePriceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.wholesalePrice ?? '';
    return TextFormField(
      key: const Key('item_ws_field'),
      initialValue:
          state.wholesalePrice == 0 ? '' : state.wholesalePrice.toString(),
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Wholesale Price',
        hintText: hintText == 0 ? '' : hintText.toString(),
      ),
      onChanged: (value) => context
          .read<ItemBloc>()
          .add(ItemWholeSalePriceChanged(int.parse(value))),
    );
  }
}

class _DescField extends StatelessWidget {
  const _DescField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ItemBloc>().state;
    final hintText = state.initialItem?.description ?? '';
    return TextFormField(
      key: const Key('item_desc_field'),
      initialValue: state.desc,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Description',
        hintText: hintText,
      ),
      onChanged: (value) =>
          context.read<ItemBloc>().add(ItemDescChanged(value)),
    );
  }
}

class ItemCategory extends StatelessWidget {
  const ItemCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TextFormField(
          decoration: const InputDecoration(labelText: 'Category'),
        )),
        IconButton(
            onPressed: () => _dialogBuilder(context),
            icon: const Icon(Icons.add)),
      ],
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
            )
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
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
