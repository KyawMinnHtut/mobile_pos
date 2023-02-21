part of 'category_item_bloc.dart';

enum CategoryItemStatus { initial, loading, success, failure }

extension CategoryStatusX on CategoryItemStatus {
  bool get isLoadingOrSuccess => [
        CategoryItemStatus.loading,
        CategoryItemStatus.success,
      ].contains(this);
}

class CategoryItemState extends Equatable {
  final CategoryItemStatus status;
  final Category? initialCategory;
  final String name;
  final String? description;

  const CategoryItemState(
      {this.status = CategoryItemStatus.initial,
      this.initialCategory,
      this.name = '',
      this.description = ''});

  bool get isNewCategory => initialCategory == null;
  
  CategoryItemState copyWith({
  CategoryItemStatus? status,
    Category? initialCategory,
    String? name,
    String? description,
}) {
    return CategoryItemState(
      status: status ?? this.status,
      initialCategory: initialCategory ?? this.initialCategory,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialCategory, name, description];
}
