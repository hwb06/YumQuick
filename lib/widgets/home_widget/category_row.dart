import 'package:flutter/material.dart';
import '../../data/models/category.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class CategoryRow extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<Category> onTap;
  final String? selectedId;

  const CategoryRow({
    super.key,
    required this.categories,
    required this.onTap,
    this.selectedId, required bool showLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((c) {
        final selected = c.id == selectedId;
        return GestureDetector(
          onTap: () => onTap(c),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: context.w(52),
                height: context.w(68),
                decoration: BoxDecoration(
                  color: selected ? AppColors.secondary : AppColors.chipBg,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Image.asset(
                    c.icon,
                    width: context.w(30),
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.restaurant, color: AppColors.primary),
                  ),
                ),
              ),
              4.vGap,
              Text(c.name, style: AppStyles.body(size: context.sp(10), w: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
    );
  }
}