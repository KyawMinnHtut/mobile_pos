// import 'package:pos_api/pos_api.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;
//
// class DatabaseApiImpl implements DatabaseApi {
//
//   DatabaseApiImpl._privateConstructor();
//   static final DatabaseApiImpl instance = DatabaseApiImpl._privateConstructor();
//
//   // only have a single app-wide reference to the database
//   static Database? _database;
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     // lazily instantiate the db the first time it is accessed
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   // this opens the database (and creates it if it doesn't exist)
//   _initDatabase() async {
//     String dbPath = await getDatabasesPath();
//     String dataPath = p.join(dbPath, 'pos.db');
//     await openDatabase(dataPath, version: 1, onCreate: _onCreate);
//   }
//   // final _categoryStreamController = BehaviorSubject<List<Category>>.seeded(const []);
//   // final _personStreamController = BehaviorSubject<List<Person>>.seeded(const []);
//   // final _itemStreamController = BehaviorSubject<List<Item>>.seeded(const []);
//   // final _invoiceStreamController = BehaviorSubject<List<Invoice>>.seeded(const []);
//   // final _saleStreamController = BehaviorSubject<List<Sale>>.seeded(const []);
//   // final _expenseManagerStreamController = BehaviorSubject<List<ExpenseManager>>.seeded(const []);
//
//   // SQL code to create the database table
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//           CREATE TABLE category(
// 	  id INTEGER PRIMARY KEY,
//     name TEXT,
//     desc TEXT
//     )''');
//
//     await db.execute('''
//           CREATE TABLE person(
// 	  id INTEGER PRIMARY KEY,
//     name TEXT,
//     ph_number TEXT,
//     address TEXT,
//     is_customer INT
//     )''');
//
//     await db.execute('''
//           CREATE TABLE item(
// 	  id INTEGER PRIMARY KEY,
//     supplier_id INT,
//     name TEXT,
//     quantity INT
//     category_id INT,
//     purchase_price INT,
//     retail_price INT,
//     wholesale_price INT,
//     desc TEXT
//     )''');
//
//     await db.execute('''
//           CREATE TABLE invoice(
// 	  id INTEGER PRIMARY KEY,
//     person_id INT,
//     date_recorded TEXT,
//     total_amount INT
//     is_sale INT
//     )''');
//
//     await db.execute('''
//           CREATE TABLE sale(
// 	  id INTEGER PRIMARY KEY,
//     invoice_id INT,
//     item_id INT,
//     item_price INT
//     item_qty INT
//     )''');
//
//     await db.execute('''
//           CREATE TABLE expense_manager(
// 	  id INTEGER PRIMARY KEY,
// 	  desc TEXT,
//     amount INT,
//     remark TEXT,
//     is_income INT
//     date_recorded INT
//     )''');
//   }
//
//   @override
//   Future<void> deleteCategory(int id) async {
//     Database db = await instance.database;
//     await db.delete('category', where: 'id=?', whereArgs: [id]);
//   }
//
//   @override
//   Future<void> deleteInvoice(int id) async {
//     Database db = await instance.database;
//     await db.delete('invoice', where: 'id=?', whereArgs: [id]);
//   }
//
//   @override
//   Future<void> deleteItem(int id) async {
//     Database db = await instance.database;
//     await db.delete('item', where: 'id=?', whereArgs: [id]);
//   }
//
//   @override
//   Future<void> deletePerson(int id) async {
//     Database db = await instance.database;
//     await db.delete('person', where: 'id=?', whereArgs: [id]);
//   }
//
//   @override
//   Future<void> deleteExpenseManager(int id) async {
//     Database db = await instance.database;
//     await db.delete('transaction', where: 'id=?', whereArgs: [id]);
//   }
//
//   @override
//   Future<List<Item>> getAllItems({int? supplierId}) async {
//     Database db = await instance.database;
//     if (supplierId != null) {
//       List<Item> items =
//           (await db.query('item', where: 'supplier_id=?', whereArgs: [supplierId]))
//               .cast<Item>();
//       return items;
//     }
//     final List<Item> items = (await db.query('item')).cast<Item>();
//     return items;
//   }
//
//   @override
//   Future<List<Category>> getCategories() async {
//     Database db = await instance.database;
//     final List<Category> categories = (await db.query('category')).cast<Category>();
//     return categories;
//   }
//
//   @override
//   Future<Invoice> getInvoiceById(int id) async {
//     Database db = await instance.database;
//     List<Invoice> result =
//         (await db.query('invoice', where: 'id=?', whereArgs: [id]))
//             .cast<Invoice>();
//     if (result.isNotEmpty) {
//       return result[0];
//     } else {
//       throw InvoiceNotFoundException();
//     }
//   }
//
//   @override
//   Future<List<Invoice>> getInvoices(
//       {required int isSale, String? dateRecorded}) async{
//     Database db = await instance.database;
//     if (dateRecorded != null) {
//       List<Invoice> invoices =
//       (await db.query('item', where: 'is_sale=? AND data_recorded=?', whereArgs: [isSale, dateRecorded])).cast<Invoice>();
//       return invoices;
//     }
//
//     final List<Invoice> invoices = (await db.query('invoice', where: 'is_sale=?', whereArgs: [isSale])).cast<Invoice>();
//     return invoices;
//   }
//
//   @override
//   Future<Item> getItemById(int id) async {
//     Database db = await instance.database;
//     List<Item> result =
//         (await db.query('item', where: 'id=?', whereArgs: [id])).cast<Item>();
//     if (result.isNotEmpty) {
//       return result[0];
//     } else {
//       throw ItemNotFoundException();
//     }
//   }
//
//   @override
//   Future<Person> getPersonById(int id) async {
//     Database db = await instance.database;
//     List<Person> result =
//         (await db.query('person', where: 'id=?', whereArgs: [id]))
//             .cast<Person>();
//     if (result.isNotEmpty) {
//       return result[0];
//     } else {
//       throw PersonNotFoundException();
//     }
//   }
//
//   @override
// Future<List<Person>> getPersons() async {
//     Database db = await instance.database;
//     final List<Person> persons = (await db.query('person')).cast<Person>();
//     print(persons);
//     return persons;
//   }
// //   @override
// //   Stream<List<Person>> getPersons() {
// //     return _personStreamController.asBroadcastStream();
// //   }
//
//   @override
//   Future<List<Sale>> getSales(int invoiceId) async{
//     Database db = await instance.database;
//     final List<Sale> sales = (await db.query('sale', where: 'id=?', whereArgs: [invoiceId] )).cast<Sale>();
//     return sales;
//   }
//
//   @override
//   Future<void> saveCategory(Category category) async {
//     Database db = await instance.database;
//     await db.insert('category', category.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: '');
//   }
//
//   @override
//   Future<int> saveInvoice(Invoice invoice) async{
//     Database db = await instance.database;
//     return await db.insert('invoice', invoice.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: '');
//   }
//
//   @override
//   Future<void> saveItem(Item item) async {
//     Database db = await instance.database;
//     await db.insert('item', item.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: '');
//   }
//
//   @override
//   Future<void> savePerson(Person person) async {
//     Database db = await instance.database;
//     await db.insert('person', person.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace, nullColumnHack: '');
//   }
//
//   @override
//   Future<void> saveSale(Sale sale, int invoiceId) async {
//     Database db = await instance.database;
//     await db.insert('sale', sale.copyWith(invoiceId: invoiceId).toJson(),
//         conflictAlgorithm: ConflictAlgorithm.ignore, nullColumnHack: '');
//   }
//
//   @override
//   Future<void> updateItemById(
//       {required int id,
//       int? supplierId,
//       String? name,
//       int? categoryId,
//       int? quantity,
//       int? purchasePrice,
//       int? retailPrice,
//       int? wholesalePrice,
//       String? desc}) {
//     // TODO: implement updateItemById
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> updatePersonById(
//       {required int id, String? name, String? phNumber, String? address}) {
//     // TODO: implement updatePersonById
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<ExpenseManager> getExpenseManagerById(int id) async{
//     Database db = await instance.database;
//     List<ExpenseManager> result =
//     (await db.query('expense_manager', where: 'id=?', whereArgs: [id]))
//         .cast<ExpenseManager>();
//     if (result.isNotEmpty) {
//     return result[0];
//     } else {
//     throw ExpenseManagerNotFoundException();
//     }
//   }
//
//   @override
//   Future<List<ExpenseManager>> getExpenseManagers(
//       {required int isIncome, String? dateRecorded}) async{
//     Database db = await instance.database;
//     if (dateRecorded != null) {
//       List<ExpenseManager> results =
//       (await db.query('expense_manager', where: 'is_income=? AND date_recorded=?', whereArgs: [isIncome, dateRecorded]))
//           .cast<ExpenseManager>();
//       return results;
//     }
//     List<ExpenseManager> results =
//     (await db.query('expense_manager', where: 'is_income=?', whereArgs: [isIncome]))
//         .cast<ExpenseManager>();
//     return results;
//   }
//
//   @override
//   Future<void> saveExpenseManager(ExpenseManager expenseManager) async {
//     Database db = await instance.database;
//     await db.insert('sale', expenseManager.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.ignore, nullColumnHack: '');
//   }
//
//   @override
//   Future<void> updateExpenseManagerById(
//       {required int id, String? description, int? amount, String? remark}) {
//     // TODO: implement updateExpenseManagerById
//     throw UnimplementedError();
//   }
// }
