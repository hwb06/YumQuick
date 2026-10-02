import 'package:flutter/material.dart';
import '../../data/models/food_summary.dart';
import '../../helpers/app_extensions.dart';
import '../app_widgets/food_image.dart';
import '../app_widgets/price_tag.dart';

class BestSellerList extends StatelessWidget {
  final List<FoodSummary> items;
  final ValueChanged<FoodSummary> onTap;

  const BestSellerList({super.key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.w(108),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.w(16)),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: context.w(10)),
        itemBuilder: (_, i) {
          final item = items[i];
          return GestureDetector(
            onTap: () => onTap(item),
            child: SizedBox(
              width: context.w(72),
              child: Stack(
                children: [
                  Positioned.fill(child: FoodImage(src: item.image, radius: 14)),
                  Positioned(right: 0, bottom: 0, child: PriceTag(price: item.price)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}