import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    (Icons.home_outlined, 'Home'),
    (Icons.room_service_outlined, 'Meals'),
    (Icons.favorite_border_rounded, 'Favorites'),
    (Icons.assignment_outlined, 'Orders'),
    (Icons.headset_mic_outlined, 'Support'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 8), // safe area + extra gap
        child: Padding(
          padding: EdgeInsets.only(top: context.w(8)),
          child: Row(
            children: List.generate(_items.length, (i) {
              final selected = i == currentIndex;
              final (icon, label) = _items[i];
              return Expanded(
                child: Semantics(
                  button: true,
                  selected: selected,
                  label: label,
                  child: InkWell(
                    onTap: () => onTap(i),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.secondary : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              size: context.w(22),
                              color: selected ? AppColors.primary : AppColors.white,
                            ),
                          ),
                          2.vGap,
                          Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.body(
                              size: context.sp(10),
                              color: selected ? AppColors.secondary : AppColors.white,
                              w: selected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

void handleSubScreenNavTap(BuildContext context, int index) {
  if (index == 0) {
    Navigator.popUntil(context, (r) => r.isFirst);
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Coming soon')));
  }
}