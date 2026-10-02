import 'package:equatable/equatable.dart';
import 'topping.dart';

class FoodDetail extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;
  final String optionsTitle;
  final List<Topping> toppings;

  const FoodDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.optionsTitle,
    required this.toppings,
  });

  factory FoodDetail.fromJson(Map<String, dynamic> j) => FoodDetail(
    id: j['id'] as String,
    name: j['name'] as String,
    description: (j['description'] ?? '') as String,
    price: (j['price'] as num).toDouble(),
    rating: ((j['rating'] ?? 0) as num).toDouble(),
    image: j['image'] as String,
    optionsTitle: (j['optionsTitle'] ?? 'Add ons') as String,
    toppings: ((j['toppings'] ?? []) as List)
        .map((e) => Topping.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  @override
  List<Object?> get props => [id, name, price, rating, image, optionsTitle, toppings];
}