import 'package:equatable/equatable.dart';

class FoodSummary extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;
  final String categoryId;

  const FoodSummary({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.categoryId,
  });

  factory FoodSummary.fromJson(Map<String, dynamic> j) => FoodSummary(
    id: j['id'] as String,
    name: j['name'] as String,
    description: (j['description'] ?? '') as String,
    price: (j['price'] as num).toDouble(),
    rating: ((j['rating'] ?? 0) as num).toDouble(),
    image: j['image'] as String,
    categoryId: (j['categoryId'] ?? '') as String,
  );

  @override
  List<Object?> get props => [id, name, price, rating, image, categoryId];
}