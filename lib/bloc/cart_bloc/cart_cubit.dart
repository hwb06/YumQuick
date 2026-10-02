import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends Equatable {
  final String foodId;
  final String name;
  final String image;
  final int qty;
  final double unitPrice; // base + toppings
  final List<String> toppings;

  const CartItem({
    required this.foodId,
    required this.name,
    required this.image,
    required this.qty,
    required this.unitPrice,
    required this.toppings,
  });

  double get total => unitPrice * qty;

  @override
  List<Object?> get props => [foodId, name, qty, unitPrice, toppings];
}

class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super(const []);

  void add(CartItem item) => emit([...state, item]);
  void clear() => emit(const []);

  int get count => state.fold(0, (s, e) => s + e.qty);
  double get total => state.fold(0.0, (s, e) => s + e.total);
}