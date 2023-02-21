// import 'package:flutter/material.dart';
// import 'package:mobile_pos/contacts/contacts.dart';
// import 'package:mobile_pos/dashboard/dashboard.dart';
// import 'package:mobile_pos/expense_manager/expense_manager.dart';
// import 'package:mobile_pos/inventory/inventory.dart';
// import 'package:mobile_pos/purchase/purchase.dart';
// import 'package:mobile_pos/sale/sale.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final List pages = const [
//     DashBoardPage(),
//     SalesPage(),
//     PurchasePage(),
//     InventoryPage(),
//     ContactsPage(),
//     ExpenseManagerPage(),
//   ];
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Dashboard') ,),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(child: Center(child: Text('Mobile POS'))),
//             ListTile(
//               title: const Text('Dashboard'),
//               onTap: () {
//                 setState(() {
//                   index = 0;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Sale'),
//               onTap: () {
//                 setState(() {
//                   index = 1;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Purchase'),
//               onTap: () {
//                 setState(() {
//                   index = 2;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Inventory'),
//               onTap: () {
//                 setState(() {
//                   index = 3;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Contacts'),
//               onTap: () {
//                 setState(() {
//                   index = 4;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Expense Manager'),
//               onTap: () {
//                 setState(() {
//                   index = 5;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//
//           ],
//         ),
//       ),
//       body: pages[index],
//     );
//   }
// }
