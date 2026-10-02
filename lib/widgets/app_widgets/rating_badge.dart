import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(6), vertical: context.w(2)),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(rating.toStringAsFixed(1),
              style: AppStyles.body(size: context.sp(9), color: AppColors.white, w: FontWeight.w700)),
          2.hGap,
          Icon(Icons.star_rounded, color: AppColors.secondary, size: context.w(10)),
        ],
      ),
    );
  }
}