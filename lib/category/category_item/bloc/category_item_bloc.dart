import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_repository/pos_repository.dart';

part 'category_item_event.dart';
part 'category_item_state.dart';

class CategoryItemBloc extends Bloc<CategoryItemEvent, CategoryItemState> {
  final PosRepository _posReopository;
  CategoryItemBloc({required PosRepository posReopository, required Category? initialCategory})
      : _posReopository = posReopository,
        super(CategoryItemState(
        initialCategory: initialCategory,
        name: initialCategory?.name ?? '',
        description: initialCategory?.description ?? '',
      )) {
    on<CategoryNameChanged>(_onNamedChanged);
    on<CategoryDescChanged>(_onDescChanged);
    on<CategorySubmitted>(_onSubmitted);
   }


  void _onNamedChanged(CategoryNameChanged event, Emitter<CategoryItemState> emit){
    emit(state.copyWith(name: event.name));
  }

  void _onDescChanged(CategoryDescChanged event, Emitter<CategoryItemState> emit) {
    emit(state.copyWith(description: event.desc));
  }

  Future<void> _onSubmitted(CategorySubmitted event, Emitter<CategoryItemState> emit)  async{
    emit(state.copyWith(status: CategoryItemStatus.loading));
    final category = (state.initialCategory ?? const Category(name: '', description: '', )).copyWith(
      name: state.name,
      description: state.description,
    );
    try {
      await _posReopository.saveCategory(category);
      emit(state.copyWith(status: CategoryItemStatus.success));
    } catch (e){
      emit(state.copyWith(status: CategoryItemStatus.failure));
    }
  }
}
