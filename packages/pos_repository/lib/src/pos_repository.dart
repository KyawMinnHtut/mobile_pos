import 'package:pos_api/pos_api.dart';

class PosRepository {
  const PosRepository({required DatabaseApi api}) : _api = api;
  final DatabaseApi _api;

  Future<void> saveCategory(Category category) => _api.saveCategory(category);
  Stream<List<Category>> getCategories() => _api.getCategories();
  Future<List<Category>> getCategoriesForItem() => _api.getCategoriesForItem();
  Future<void> deleteCategory(String name) => _api.deleteCategory(name);
  // Future<Category> getCategoryById(int id) => _api.getCategoryById(id);

  Future<void> saveExpenseManager(ExpenseManager expenseManager) =>
      _api.saveExpenseManager(expenseManager);
  Future<ExpenseManager> getExpenseManagerById(int id) =>
      _api.getExpenseManagerById(id);
  Future<void> deleteExpenseManager(int id) => _api.deleteExpenseManager(id);
  Stream<List<ExpenseManager>> getExpenseManagers() =>
      _api.getExpenseManagers();

  Future<void> savePerson(Person person) => _api.savePerson(person);
  Stream<List<Person>> getPersons() => _api.getPersons();
  Future<Person> getPersonById(String name) => _api.getPersonById(name);
  Future<void> deletePerson(String name) => _api.deleteContact(name);

  Future<void> saveItem(Item item) => _api.saveItem(item);
  Stream<List<Item>> getAllItems() => _api.getAllItems();
  // Future<Item> getItemById(int id) => _api.getItemById(id);
  Future<void> deleteItem(String name) => _api.deleteItem(name);

  Future<int> saveInvoice(Invoice invoice) => _api.saveInvoice(invoice);
  Stream<List<Invoice>> getInvoices({required bool isSale}) =>
      _api.getInvoices(isSale: isSale);
  Future<Invoice> getInvoiceById(int id) => _api.getInvoiceById(id);
  Future<void> deleteInvoice(int id) => _api.deleteInvoice(id);

  Future<void> saveSale({required Item item, Invoice? invoice}) async {
    // await _api.updateItemByName(name: item.name, quantity: item.quantity-1);
    final int itemQty = await _api.getItemByName(item.name).then((value) => value.quantity);
    if (itemQty >0) {
      if (invoice != null) {
        int invoiceId = await _api.saveInvoice(invoice);
        _api
            .saveSale(
            sale: Sale(
                item: item.name,
                itemPrice: item.retailPrice,
                itemQuantity: 1),
            invoiceId: invoiceId)
            .then((value) =>
            _api.updateItemByName(
                name: item.name, quantity: item.quantity - 1));
      } else {
        _api
            .saveSale(
            sale: Sale(
                item: item.name,
                itemPrice: item.retailPrice,
                itemQuantity: 1))
            .then((value) =>
            _api.updateItemByName(
                name: item.name, quantity: item.quantity - 1));
      }
    } else {

    }
  }

  Future<void> updateSale(Sale sale, bool isIncrease) async {
    print('updateSale is called');
    final Item item = await _api.getItemByName(sale.item);
    if (item.quantity >0 && isIncrease) {
        await _api.updateItemByName(name: sale.item, quantity: item.quantity-1);
        await _api.saveSale(sale: sale, isIncrease: isIncrease);
    } else if (item.quantity >0 && !isIncrease) {
    await _api.updateItemByName(name: sale.item, quantity: item.quantity+1);
    await _api.saveSale(sale: sale, isIncrease: isIncrease);
    } else {

    }
  }

  Future<void> deleteSale(Sale sale) async {
    final Item item = await _api.getItemByName(sale.item);
    await _api.updateItemByName(
        name: item.name, quantity: item.quantity + sale.itemQuantity);
    _api.deleteSale(sale.id!);
  }

  Stream<List<Sale>> getSales({int? invoiceId}) =>
      _api.getSales(invoiceId: invoiceId);
}
