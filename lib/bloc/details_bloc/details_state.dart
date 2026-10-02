import 'package:equatable/equatable.dart';
import '../../data/models/food_detail.dart';
import '../../data/models/topping.dart';

enum DetailsStatus { loading, success, failure }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final FoodDetail? food;
  final int qty;
  final Set<String> selectedIds;
  final bool isFavorite;
  final String? error;

  const DetailsState({
    this.status = DetailsStatus.loading,
    this.food,
    this.qty = 1,
    this.selectedIds = const {},
    this.isFavorite = false,
    this.error,
  });

  List<Topping> get selectedToppings =>
      food == null ? [] : food!.toppings.where((t) => selectedIds.contains(t.id)).toList();

  double get unitPrice =>
      (food?.price ?? 0) + selectedToppings.fold(0.0, (s, t) => s + t.price);

  double get total => unitPrice * qty;

  DetailsState copyWith({
    DetailsStatus? status,
    FoodDetail? food,
    int? qty,
    Set<String>? selectedIds,
    bool? isFavorite,
    String? error,
  }) =>
      DetailsState(
        status: status ?? this.status,
        food: food ?? this.food,
        qty: qty ?? this.qty,
        selectedIds: selectedIds ?? this.selectedIds,
        isFavorite: isFavorite ?? this.isFavorite,
        error: error,
      );

  @override
  List<Object?> get props => [status, food, qty, selectedIds, isFavorite, error];
}