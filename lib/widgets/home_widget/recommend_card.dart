import 'package:flutter/material.dart';
import '../../data/models/food_summary.dart';
import '../../helpers/app_extensions.dart';
import '../app_widgets/food_image.dart';
import '../app_widgets/price_tag.dart';
import '../app_widgets/rating_pill.dart';

class RecommendCard extends StatelessWidget {
  final FoodSummary food;
  final VoidCallback onTap;

  const RecommendCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(child: FoodImage(src: food.image, radius: 16)),
          Positioned(
            top: context.w(8),
            left: context.w(8),
            child: RatingPill(rating: food.rating),
          ),
          Positioned(right: 0, bottom: 0, child: PriceTag(price: food.price, radius: 16)),
        ],
      ),
    );
  }
}