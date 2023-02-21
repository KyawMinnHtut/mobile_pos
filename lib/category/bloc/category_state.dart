part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

class CategoryPageState extends Equatable {
  const CategoryPageState({
    this.status = CategoryStatus.initial,
    this.categories = const [],
    this.lastDeletedCategory,
  });

  final CategoryStatus status;
  final List<Category> categories;
  final Category? lastDeletedCategory;

  CategoryPageState copyWith({
    CategoryStatus Function()? status,
    List<Category> Function()? categories,
    Category? Function()? lastDeletedCategory,
  }) {
    return CategoryPageState(
      status: status != null ? status() : this.status,
      categories: categories != null ? categories() : this.categories,
      lastDeletedCategory: lastDeletedCategory != null
          ? lastDeletedCategory()
          : this.lastDeletedCategory,
    );
  }

  @override
  List<Object?> get props => [status, categories, lastDeletedCategory];
}
