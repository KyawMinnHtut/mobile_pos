import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Center(child: Text('Mobile POS'))),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Sale'),
            onTap: () {
              Navigator.pushNamed(context, '/sale');
            },
          ),
          ListTile(
            title: const Text('Purchase'),
            onTap: () {
              Navigator.pushNamed(context, '/purchase');
            },
          ),
          ListTile(
            title: const Text('Inventory'),
            onTap: () {
              Navigator.pushNamed(context, '/inventory');
            },
          ),
          ListTile(
            title: const Text('Contacts'),
            onTap: () {
              Navigator.pushNamed(context, '/contacts');
            },
          ),
          ListTile(
            title: const Text('Expense Manager'),
            onTap: () {
              Navigator.pushNamed(context, '/expensemanager');
            },
          ),

        ],
      ),
    );
  }
}
