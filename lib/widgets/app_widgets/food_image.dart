import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';

/// Asset aur network dono images handle karta hai (real API ke liye ready).
class FoodImage extends StatelessWidget {
  final String src;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  const FoodImage({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.radius = 14,
    this.fit = BoxFit.cover,
  });

  Widget _placeholder() => Container(
    width: width,
    height: height,
    color: AppColors.chipBg,
    child: const Icon(Icons.fastfood_rounded, color: AppColors.primary),
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child:
          src.startsWith('http')
              ? Image.network(
                src,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
              : Image.asset(
                src,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (_, e, __) {
                  debugPrint('Image error: $src -> $e');
                  return _placeholder();
                },
              ),
    );
  }
}
