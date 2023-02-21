part of 'temp_bloc.dart';

abstract class TempEvent extends Equatable {
  const TempEvent();

  @override
  List<Object?> get props => [];
}

class TempListRequested extends TempEvent {
  const TempListRequested();
}

// class TempItemAdded extends TempEvent {
//   final Sale item;
//
//   const TempItemAdded(this.item);
//
//   @override
//   List<Object?> get props => [item];
//
// }

class TempItemDeleted extends TempEvent {
  final Item item;

  const TempItemDeleted(this.item);

  @override
  List<Object?> get props => [item];

}

class TempItemQtyIncreased extends TempEvent {

}
