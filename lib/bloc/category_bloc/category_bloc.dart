import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/food_summary.dart';
import '../../data/network/api_client.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiClient _api;

  CategoryBloc(this._api) : super(const CategoryState()) {
    on<CategoryStarted>(_onStarted);
    on<CategorySelected>(_onSelected);
    on<CategorySortChanged>(
          (e, emit) => emit(state.copyWith(sort: e.sort, foods: _sorted(state.foods, e.sort))),
    );
  }

  List<FoodSummary> _sorted(List<FoodSummary> list, SortOption s) {
    final out = [...list];
    switch (s) {
      case SortOption.popular:
        out.sort((a, b) => b.rating.compareTo(a.rating));
      case SortOption.priceLow:
        out.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceHigh:
        out.sort((a, b) => b.price.compareTo(a.price));
    }
    return out;
  }

  Future<void> _onStarted(CategoryStarted e, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading, selectedId: e.categoryId));
    try {
      final cats = await _api.fetchCategories();
      final foods = await _api.fetchFoods(categoryId: e.categoryId);
      emit(state.copyWith(
        status: CategoryStatus.success,
        categories: cats,
        foods: _sorted(foods, state.sort),
      ));
    } catch (err) {
      emit(state.copyWith(status: CategoryStatus.failure, error: err.toString()));
    }
  }

  Future<void> _onSelected(CategorySelected e, Emitter<CategoryState> emit) async {
    if (e.categoryId == state.selectedId && state.status == CategoryStatus.success) return;
    emit(state.copyWith(status: CategoryStatus.loading, selectedId: e.categoryId));
    try {
      final foods = await _api.fetchFoods(categoryId: e.categoryId);
      emit(state.copyWith(status: CategoryStatus.success, foods: _sorted(foods, state.sort)));
    } catch (err) {
      emit(state.copyWith(status: CategoryStatus.failure, error: err.toString()));
    }
  }
}