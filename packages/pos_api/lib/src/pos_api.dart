import 'package:pos_api/pos_api.dart';

abstract class DatabaseApi {
  const DatabaseApi();

  Future<void> saveCategory(Category category);
  Stream<List<Category>> getCategories();
  Future<void> deleteCategory(String name);

  Future<void> saveExpenseManager(ExpenseManager expenseManager);
  Stream<List<ExpenseManager>> getExpenseManagers();
  Future<ExpenseManager> getExpenseManagerById(int id);
  Future<void> updateExpenseManagerById({required int id, String? description, int? amount, String? remark});
  Future<void> deleteExpenseManager(int id);

  Future<int> saveInvoice(Invoice invoice);
  Stream<List<Invoice>> getInvoices({required bool isSale});
  Future<Invoice> getInvoiceById(int id);
  Future<void> deleteInvoice(int id);

  Future<void> saveItem(Item item);
  Stream<List<Item>> getAllItems();
  Future<Item> getItemByName(String name);
  Future<void> updateItemByName({int? supplierId, required String name, int? categoryId, int? quantity, int? purchasePrice, int? retailPrice, int? wholesalePrice, String? desc});
  Future<void> deleteItem(String name);

  Future<void> savePerson(Person person);
  Stream<List<Person>> getPersons();
  Future<Person> getPersonById(String name);
  Future<void> updatePersonById({ required String name, required Person person});
  Future<void> deleteContact(String name);

  Future<void> saveSale({required Sale sale, int? invoiceId, bool? isIncrease});
  Stream<List<Sale>> getSales({int? invoiceId});
  Future<void> deleteSale(int id);

  Future<List<Category>> getCategoriesForItem();

  // Future<Category> getCategoryById(int id);

}

class CategoryNotFoundException implements Exception {}
class ExpenseManagerNotFoundException implements Exception {}
class InvoiceNotFoundException implements Exception{}
class ItemNotFoundException implements Exception{}
class PersonNotFoundException implements Exception{}
class SaleNotFoundException implements Exception{}