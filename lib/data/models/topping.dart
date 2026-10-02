import 'package:equatable/equatable.dart';

class Topping extends Equatable {
  final String id;
  final String name;
  final double price;

  const Topping({required this.id, required this.name, required this.price});

  factory Topping.fromJson(Map<String, dynamic> j) => Topping(
    id: j['id'] as String,
    name: j['name'] as String,
    price: (j['price'] as num).toDouble(),
  );

  @override
  List<Object?> get props => [id, name, price];
}