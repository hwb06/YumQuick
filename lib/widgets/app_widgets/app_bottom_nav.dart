import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _icons = [
    Icons.home_outlined,
    Icons.room_service_outlined,
    Icons.favorite_border_rounded,
    Icons.assignment_outlined,
    Icons.headset_mic_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h(64),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (i) {
            final selected = i == currentIndex;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selected ? AppColors.secondary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icons[i],
                  size: context.w(24),
                  color: selected ? AppColors.primary : AppColors.white,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Category/Details screens ke liye nav handler
void handleSubScreenNavTap(BuildContext context, int index) {
  if (index == 0) {
    Navigator.popUntil(context, (r) => r.isFirst);
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Coming soon')));
  }
}