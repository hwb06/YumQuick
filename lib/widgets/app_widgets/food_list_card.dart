import 'package:flutter/material.dart';
import '../../data/models/food_summary.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';
import 'food_image.dart';
import 'rating_badge.dart';

class FoodListCard extends StatelessWidget {
  final FoodSummary food;
  final VoidCallback onTap;

  const FoodListCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FoodImage(src: food.image, width: double.infinity, height: context.w(150), radius: 20),
          8.vGap,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(food.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.heading(size: context.sp(15))),
                    ),
                    6.hGap,
                    RatingBadge(rating: food.rating),
                  ],
                ),
              ),
              Text('\$${food.price.toStringAsFixed(2)}',
                  style: AppStyles.heading(size: context.sp(14)).copyWith(color: AppColors.primary)),
            ],
          ),
          2.vGap,
          Text(food.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey)),
        ],
      ),
    );
  }
}