import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pos_api/pos_api.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'drift_api.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class ContactTable extends Table {
  TextColumn get name => text().withLength(min: 1, max: 32)();
  TextColumn get phNumber => text().named('phNumber')();
  TextColumn get address => text().named('address')();
  BoolColumn get isCustomer => boolean().named('is_customer')();

  @override
  Set<Column<Object>>? get primaryKey => {name};
}

class CategoryTable extends Table {
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('desc')();

  @override
  Set<Column<Object>>? get primaryKey => {name};
}

class ItemTable extends Table {
  TextColumn get name => text().named('item_name')();
  IntColumn get qty => integer().named('quantity')();
  TextColumn get category =>
      text().named('category').references(CategoryTable, #name)();
  IntColumn get purchasePrice => integer().named('purchase_price')();
  IntColumn get retailPrice => integer().named('retail_price')();
  IntColumn get wholeSalePrice => integer().named('wholesale_price')();
  TextColumn get desc => text().named('desc')();

  @override
  Set<Column<Object>>? get primaryKey => {name};
}

class TransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get desc => text().named('desc')();
  IntColumn get amount => integer().named('amount')();
  TextColumn get remark => text().named('remark')();
  BoolColumn get isIncome => boolean().named('is_income')();
  DateTimeColumn get dateRecorded => dateTime().named('date_recorded')();
}

class InvoiceTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get person =>
      text().named('person').references(ContactTable, #name)();
  DateTimeColumn get dateRecorded => dateTime().named('date_recorded')();
  IntColumn get totalAmount => integer().named('total_amount')();
  BoolColumn get isSale => boolean().named('is_sale')();
}

class SaleTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId =>
      integer().named('invoice_id').nullable().references(InvoiceTable, #id)();
  TextColumn get item => text().named('item').references(ItemTable, #name)();
  IntColumn get itemPrice => integer().named('item_price')();
  IntColumn get itemQty => integer().named('item_qty')();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [
  ContactTable,
  CategoryTable,
  ItemTable,
  TransactionTable,
  InvoiceTable,
  SaleTable
])
class DatabaseImpl extends _$DatabaseImpl implements DatabaseApi {
  // we tell the database where to store the data with this constructor
  DatabaseImpl() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // Add a bunch of default items in a batch
        await batch((b) {
          b.insertAll(invoiceTable, [
            InvoiceTableCompanion.insert(
                id: const Value(1),
                person: "Ko Ko",
                dateRecorded: DateTime.now(),
                totalAmount: 10000,
                isSale: true),
            InvoiceTableCompanion.insert(
                id: const Value(2),
                person: "Mg Mg",
                dateRecorded: DateTime.now(),
                totalAmount: 20000,
                isSale: true),
            InvoiceTableCompanion.insert(
                id: const Value(3),
                person: "Nyi Nyi",
                dateRecorded: DateTime.now(),
                totalAmount: 30000,
                isSale: true),
            InvoiceTableCompanion.insert(
                id: const Value(4),
                person: "Ma Ma",
                dateRecorded: DateTime.now(),
                totalAmount: 40000,
                isSale: true),
            InvoiceTableCompanion.insert(
                id: const Value(5),
                person: "Moe Moe",
                dateRecorded: DateTime.now(),
                totalAmount: 50000,
                isSale: true),
          ]);
        });
      },
    );
  }

  @override
  Future<void> deleteCategory(String name) async {
    await (delete(categoryTable)..where((t) => t.name.equals(name))).go();
  }

  @override
  Future<void> deleteExpenseManager(int id) async {
    await (delete(transactionTable)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> deleteInvoice(int id) async {
    await (delete(invoiceTable)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> deleteItem(String name) async {
    await (delete(itemTable)..where((t) => t.name.equals(name))).go();
  }

  @override
  Future<void> deleteContact(String name) async {
    await (delete(contactTable)..where((t) => t.name.equals(name))).go();
  }

  @override
  Stream<List<Item>> getAllItems() {
    final query = select(itemTable).join([
      leftOuterJoin(
          categoryTable, categoryTable.name.equalsExp(itemTable.category))
    ]);
    return query.watch().map((rows) {
      return rows
          .map((row) {
            return row.readTableOrNull(itemTable);
          })
          .map((e) => Item(
              name: e!.name,
              quantity: e.qty,
              category: e!.category,
              purchasePrice: e.purchasePrice,
              retailPrice: e.retailPrice,
              wholesalePrice: e.wholeSalePrice,
              description: e.desc))
          .toList();
    });
    // id: e.read,
    // category: e.id,
    // name: e.name,
    // quantity: e.qty,
    // categoryId: e.categoryId,
    // purchasePrice: e.purchasePrice,
    // retailPrice: e.retailPrice,
    // wholesalePrice: e.wholeSalePrice,
    // description: e.desc)));
  }

  @override
  Stream<List<Category>> getCategories() {
    return select(categoryTable)
        .map<Category>(
            (e) => Category(name: e.name, description: e.description))
        .watch();
  }

  @override
  Future<ExpenseManager> getExpenseManagerById(int id) {
    // TODO: implement getExpenseManagerById
    throw UnimplementedError();
  }

  @override
  Stream<List<ExpenseManager>> getExpenseManagers() {
    return select(transactionTable)
        .map<ExpenseManager>((e) => ExpenseManager(
            id: e.id,
            description: e.desc,
            amount: e.amount,
            remark: e.remark,
            dateRecorded: e.dateRecorded,
            isIncome: e.isIncome))
        .watch();
  }

  @override
  Future<Invoice> getInvoiceById(int id) {
    // TODO: implement getInvoiceById
    throw UnimplementedError();
  }

  @override
  Stream<List<Invoice>> getInvoices({required bool isSale}) {
    return (select(invoiceTable)..where((tbl) => tbl.isSale.equals(isSale)))
        .map((e) => Invoice(
            person: e.person,
            dateRecorded: e.dateRecorded,
            totalAmount: e.totalAmount,
            isSale: e.isSale))
        .watch();
  }

  @override
  Future<Item> getItemByName(String name) {
    return (select(itemTable)..where((tbl) => tbl.name.equals(name)))
        .map((e) => Item(
            name: e.name,
            quantity: e.qty,
            category: e.category,
            purchasePrice: e.purchasePrice,
            retailPrice: e.retailPrice,
            wholesalePrice: e.wholeSalePrice,
            description: e.desc))
        .getSingle();
  }

  @override
  Future<Person> getPersonById(String name) {
    // TODO: implement getPersonById
    throw UnimplementedError();
  }

  @override
  Stream<List<Person>> getPersons() {
    return select(contactTable)
        .map<Person>((e) => Person(
            name: e.name,
            phNumber: e.phNumber,
            address: e.address,
            isCustomer: e.isCustomer))
        .watch();
  }

  @override
  Stream<List<Sale>> getSales({int? invoiceId}) {
    if (invoiceId == null) {
      return (select(saleTable)..where((tbl) => tbl.invoiceId.isNull()))
          .map((e) => Sale(
              id: e.id,
              item: e.item,
              itemPrice: e.itemPrice,
              itemQuantity: e.itemQty))
          .watch();
    }
    return (select(saleTable)..where((tbl) => tbl.invoiceId.equals(invoiceId!)))
        .map((e) => Sale(
            id: e.id,
            invoiceId: e.invoiceId,
            item: e.item,
            itemPrice: e.itemPrice,
            itemQuantity: e.itemQty))
        .watch();
  }

  @override
  Future<void> deleteSale(int id) async {
    await (delete(saleTable)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> saveCategory(Category category) async {
    final categories = await select(categoryTable)
        // .map((e) => Category(name: e.name, description: e.description))
        .get();
    final categoryIndex =
        categories.indexWhere((element) => element.name == category.name);
    if (categoryIndex >= 0) {
      (update(categoryTable)..where((tbl) => tbl.name.equals(category.name!)))
          .write(CategoryTableCompanion.insert(
              name: category.name, description: category.description));
    } else {
      into(categoryTable).insert(CategoryTableCompanion.insert(
          name: category.name, description: category.description));
    }
  }

  @override
  Future<void> saveExpenseManager(ExpenseManager expenseManager) async {
    final transactions = await select(transactionTable).get();
    final transactionIndex =
        transactions.indexWhere((element) => element.id == expenseManager.id);
    if (transactionIndex >= 0) {
      (update(transactionTable)
            ..where((tbl) => tbl.id.equals(expenseManager.id!)))
          .write(TransactionTableCompanion.insert(
        desc: expenseManager.description,
        amount: expenseManager.amount,
        remark: expenseManager.remark,
        isIncome: expenseManager.isIncome,
        dateRecorded: expenseManager.dateRecorded,
      ));
    } else {
      into(transactionTable).insert(TransactionTableCompanion.insert(
          desc: expenseManager.description,
          amount: expenseManager.amount,
          remark: expenseManager.remark,
          isIncome: expenseManager.isIncome,
          dateRecorded: expenseManager.dateRecorded));
    }
  }

  @override
  Future<int> saveInvoice(Invoice invoice) async {
    final invoices = await select(invoiceTable).get();
    final invoiceIndex =
        invoices.indexWhere((element) => element.id == invoice.id);
    if (invoiceIndex >= 0) {
      return (update(invoiceTable)..where((tbl) => tbl.id.equals(invoice.id!)))
          .write(InvoiceTableCompanion.insert(
              person: invoice.person,
              dateRecorded: invoice.dateRecorded,
              totalAmount: invoice.totalAmount,
              isSale: invoice.isSale));
    } else {
      return into(invoiceTable).insert(InvoiceTableCompanion.insert(
          person: invoice.person,
          dateRecorded: invoice.dateRecorded,
          totalAmount: invoice.totalAmount,
          isSale: invoice.isSale));
    }
  }

  @override
  Future<void> saveItem(Item item) async {
    final items = await select(itemTable).get();
    final itemIndex = items.indexWhere((element) => element.name == item.name);
    if (itemIndex >= 0) {
      (update(itemTable)..where((tbl) => tbl.name.equals(item.name!))).write(
          ItemTableCompanion.insert(
              name: item.name,
              qty: item.quantity,
              category: item.category,
              purchasePrice: item.purchasePrice,
              retailPrice: item.retailPrice,
              wholeSalePrice: item.wholesalePrice,
              desc: item.description));
    } else {
      into(itemTable).insert(ItemTableCompanion.insert(
          name: item.name,
          qty: item.quantity,
          category: item.category,
          purchasePrice: item.purchasePrice,
          retailPrice: item.retailPrice,
          wholeSalePrice: item.wholesalePrice,
          desc: item.description));
    }
  }

  @override
  Future<void> savePerson(Person person) async {
    final persons = await select(contactTable).get();
    final personIndex =
        persons.indexWhere((element) => element.name == person.name);
    if (personIndex >= 0) {
      (update(contactTable)..where((tbl) => tbl.name.equals(person.name!)))
          .write(ContactTableCompanion.insert(
        name: person.name,
        phNumber: person.phNumber,
        address: person.address,
        isCustomer: person.isCustomer,
      ));
    } else {
      into(contactTable).insert(ContactTableCompanion.insert(
        name: person.name,
        phNumber: person.phNumber,
        address: person.address,
        isCustomer: person.isCustomer,
      ));
    }
  }

  @override
  Future<void> saveSale({required Sale sale, int? invoiceId, bool? isIncrease}) async {
    final sales = await select(saleTable).get();
    final saleIndex = sales.indexWhere((element) => element.item ==sale.item && element.invoiceId == null);
    print('sales ==> $sales');
    print('saleIndex ==> $saleIndex' );
    if (saleIndex >= 0) {
      if (isIncrease == null){
        (update(saleTable)..where((tbl) => tbl.item.equals(sale.item) & tbl.invoiceId.isNull()))
            .write(SaleTableCompanion(itemQty: Value(sales[saleIndex].itemQty+1)));
      } else if (isIncrease == true){
        (update(saleTable)..where((tbl) => tbl.item.equals(sale.item) & tbl.invoiceId.isNull()))
            .write(SaleTableCompanion(itemQty: Value(sales[saleIndex].itemQty+1)));
      } else {
        (update(saleTable)..where((tbl) => tbl.item.equals(sale.item) & tbl.invoiceId.isNull()))
            .write(SaleTableCompanion(itemQty: Value(sales[saleIndex].itemQty-1)));
      }
    } else {
      into(saleTable).insert(SaleTableCompanion.insert(
          invoiceId: Value(invoiceId),
          item: sale.item,
          itemPrice: sale.itemPrice,
          itemQty: sale.itemQuantity));
    }
  }

  @override
  Future<void> updateExpenseManagerById(
      {required int id, String? description, int? amount, String? remark}) {
    // TODO: implement updateExpenseManagerById
    throw UnimplementedError();
  }

  @override
  Future<void> updateItemByName(
      {int? supplierId,
      required String name,
      int? categoryId,
      int? quantity,
      int? purchasePrice,
      int? retailPrice,
      int? wholesalePrice,
      String? desc}) {
    return (update(itemTable)..where((tbl) => tbl.name.equals(name)))
        .write(ItemTableCompanion(qty: Value(quantity!)));
  }

  @override
  Future<void> updatePersonById(
      {required String name, required Person person}) async {
    (update(contactTable)..where((tbl) => tbl.name.equals(name)))
        .write(ContactTableCompanion.insert(
      name: person.name,
      phNumber: person.phNumber,
      address: person.address,
      isCustomer: person.isCustomer,
    ));
  }

  @override
  Future<List<Category>> getCategoriesForItem() {
    return select(categoryTable)
        .map<Category>(
            (e) => Category(name: e.name, description: e.description))
        .get();
  }

  // @override
  // Future<Category> getCategoryById(String name) {
  //   return (select(categoryTable)..where((tbl) => tbl.name.equals(name)))
  //       .map(
  //           (e) => Category(name: e.name, description: e.description))
  //       .getSingle();
  // }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
