part of 'category_item_bloc.dart';

abstract class CategoryItemEvent extends Equatable {
  const CategoryItemEvent();

  @override
  List<Object?> get props => [];
}

class CategoryNameChanged extends CategoryItemEvent {

  final String name;

  const CategoryNameChanged(this.name);

  @override
  List<Object?> get props => [name];

}

class CategoryDescChanged extends CategoryItemEvent {

  final String desc;

  const CategoryDescChanged(this.desc);

  @override
  List<Object?> get props => [desc];
}

class CategorySubmitted extends CategoryItemEvent {
  const CategorySubmitted();
}
