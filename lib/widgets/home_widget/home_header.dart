import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onCartTap;
  final VoidCallback onBellTap;
  final VoidCallback onProfileTap;
  final bool showGreeting;

  const HomeHeader({
    super.key,
    required this.onCartTap,
    required this.onBellTap,
    required this.onProfileTap,
    this.showGreeting = true,
  });

  String _greeting(int h) =>
      h < 12 ? 'Good Morning' : (h < 17 ? 'Good Afternoon' : 'Good Evening');

  String _tagline(int h) => h < 12
      ? "Rise And Shine! It's Breakfast Time"
      : (h < 17 ? "Hungry? It's Lunch Time" : "Relax, It's Dinner Time");

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;

    return Container(
      color: AppColors.secondary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.w(16),
            context.h(12),
            context.w(16),
            context.h(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(child: _HeaderSearch()),
                  context.w(10).hGap,
                  _IconBox(icon: Icons.shopping_cart_outlined, onTap: onCartTap),
                  context.w(8).hGap,
                  _IconBox(icon: Icons.notifications_none_rounded, onTap: onBellTap),
                  context.w(8).hGap,
                  _IconBox(icon: Icons.person_outline_rounded, onTap: onProfileTap),
                ],
              ),
              if (showGreeting) ...[
                context.h(18).vGap,
                Text(_greeting(hour), style: AppStyles.title(size: context.sp(28))),
                2.vGap,
                Text(
                  _tagline(hour),
                  style: AppStyles.body(
                    size: context.sp(11),
                    color: AppColors.primary,
                    w: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSearch extends StatelessWidget {
  const _HeaderSearch();

  @override
  Widget build(BuildContext context) {
    final size = context.w(32);
    return Container(
      height: size,
      padding: const EdgeInsets.only(left: 12, right: 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: AppStyles.body(size: context.sp(12)),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: AppStyles.body(
                  size: context.sp(11),
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),
          Container(
            width: size - 6,
            height: size - 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.tune_rounded,
              color: AppColors.white,
              size: context.w(16),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconBox({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = context.w(32);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: context.w(18)),
      ),
    );
  }
}