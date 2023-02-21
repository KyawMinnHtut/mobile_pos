import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos_repository/pos_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryPageBloc extends Bloc<CategoryPageEvent, CategoryPageState> {
  final PosRepository _posRepository;

  CategoryPageBloc({required PosRepository posRepository})
      : _posRepository = posRepository,
        super(const CategoryPageState()) {
    on<CategorySubscriptionRequested>(_onSubscriptionRequested);
    on<CategoryDeleted>(_onCategoryDeleted);
  }

  Future<void> _onSubscriptionRequested(
      CategorySubscriptionRequested event, Emitter<CategoryPageState> emit) async {
    emit(state.copyWith(status: () => CategoryStatus.loading));
    await emit.forEach<List<Category>>(_posRepository.getCategories(),
        onData: (categories) => state.copyWith(
            status: () => CategoryStatus.success,
            categories: () => categories),
      onError: (_, __) => state.copyWith(status: () => CategoryStatus.failure),
    );
  }

  Future<void> _onCategoryDeleted(CategoryDeleted event, Emitter<CategoryPageState> emit) async {
    emit(state.copyWith(lastDeletedCategory: () => event.category));
    await _posRepository.deleteCategory(event.category.name!);
  }
}
