import 'package:equatable/equatable.dart';
import 'category.dart';
import 'food_summary.dart';
import 'promo_banner_item.dart';

class HomeData extends Equatable {
  final List<Category> categories;
  final List<FoodSummary> bestSellers;
  final List<PromoBannerItem> promos;
  final List<FoodSummary> recommended;

  const HomeData({
    required this.categories,
    required this.bestSellers,
    required this.promos,
    required this.recommended,
  });

  static List<T> _list<T>(dynamic raw, T Function(Map<String, dynamic>) f) =>
      (raw as List).map((e) => f(e as Map<String, dynamic>)).toList();

  factory HomeData.fromJson(Map<String, dynamic> j) => HomeData(
    categories: _list(j['categories'], Category.fromJson),
    bestSellers: _list(j['bestSellers'], FoodSummary.fromJson),
    promos: _list(j['promos'], PromoBannerItem.fromJson),
    recommended: _list(j['recommended'], FoodSummary.fromJson),
  );

  @override
  List<Object?> get props => [categories, bestSellers, promos, recommended];
}