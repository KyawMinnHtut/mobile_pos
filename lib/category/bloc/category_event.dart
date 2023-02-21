part of 'category_bloc.dart';

abstract class CategoryPageEvent extends Equatable {
  const CategoryPageEvent();

  @override
  List<Object?> get props => [];
}

class CategorySubscriptionRequested extends CategoryPageEvent {
  const CategorySubscriptionRequested();
}

class CategoryDeleted extends CategoryPageEvent {
  final Category category;

  const CategoryDeleted(this.category);

  @override
  List<Object?> get props => [category];
}
