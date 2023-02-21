import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/utils.dart';
import 'package:pos_repository/pos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category/category.dart';
import 'contacts/contacts.dart';
import 'dashboard/dashboard.dart';
import 'expense_manager/expense_manager.dart';
import 'inventory/inventory.dart';
import 'item/item.dart';
import 'purchase/purchase.dart';
import 'sale/sale.dart';


class App extends StatelessWidget {
  const App({Key? key, required this.posReopository}) : super(key: key);

  final PosRepository posReopository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: posReopository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile POS',
        routes: {
          '/dashboard': (_) => const DashBoardPage(),
          '/sale': (_) => const SalesPage(),
          '/purchase': (_) => const PurchasePage(),
          '/inventory': (_) => const InventoryPage(),
          '/contacts': (_) => const ContactsPage(),
          '/expensemanager': (_) => const ExpenseManagerPage(),
          '/invoice': (_) => const InvoicePage(),
          '/checkout': (_) => const CheckOutPage(),
          '/item': (_) => const ItemPage(),
          '/category': (_) => const CategoryPage(),
        },
        initialRoute: '/dashboard',
      ),
    );
  }
}
