import 'package:equatable/equatable.dart';
import '../../data/models/category.dart';
import '../../data/models/food_summary.dart';

enum CategoryStatus { loading, success, failure }

enum SortOption {
  popular('Popular'),
  priceLow('Price: Low to High'),
  priceHigh('Price: High to Low');

  const SortOption(this.label);
  final String label;
}

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<Category> categories;
  final List<FoodSummary> foods;
  final String selectedId;
  final SortOption sort;
  final String? error;

  const CategoryState({
    this.status = CategoryStatus.loading,
    this.categories = const [],
    this.foods = const [],
    this.selectedId = 'all',
    this.sort = SortOption.popular,
    this.error,
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<Category>? categories,
    List<FoodSummary>? foods,
    String? selectedId,
    SortOption? sort,
    String? error,
  }) =>
      CategoryState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
        foods: foods ?? this.foods,
        selectedId: selectedId ?? this.selectedId,
        sort: sort ?? this.sort,
        error: error,
      );

  @override
  List<Object?> get props => [status, categories, foods, selectedId, sort, error];
}