import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class RatingPill extends StatelessWidget {
  final double rating;

  const RatingPill({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(6), vertical: context.w(2)),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(rating.toStringAsFixed(1),
              style: AppStyles.body(size: context.sp(9), w: FontWeight.w700)),
          3.hGap,
          Icon(Icons.star_rounded, color: AppColors.secondary, size: context.w(11)),
          2.hGap,
          Icon(Icons.favorite_rounded, color: AppColors.primary, size: context.w(11)),
        ],
      ),
    );
  }
}