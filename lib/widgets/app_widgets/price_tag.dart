import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

/// Card ke bottom-right corner mein Positioned(right: 0, bottom: 0) ke sath lagayen.
class PriceTag extends StatelessWidget {
  final double price;
  final double radius;

  const PriceTag({super.key, required this.price, this.radius = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.w(8), vertical: context.w(3)),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      ),
      child: Text(
        '\$${price.priceLabel}',
        style: AppStyles.body(size: context.sp(10), color: AppColors.white, w: FontWeight.w700),
      ),
    );
  }
}