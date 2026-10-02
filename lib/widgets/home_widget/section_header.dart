import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_strings.dart';
import '../../helpers/app_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({super.key, required this.title, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppStyles.heading(size: context.sp(18))),
        const Spacer(),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              children: [
                Text(AppStrings.viewAll, style: AppStyles.link(size: context.sp(11))),
                Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: context.w(16)),
              ],
            ),
          ),
      ],
    );
  }
}