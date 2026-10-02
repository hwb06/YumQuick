import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/promo_banner_item.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';
import '../app_widgets/food_image.dart';

class PromoBanner extends StatefulWidget {
  final List<PromoBannerItem> items;

  const PromoBanner({super.key, required this.items});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final _ctrl = PageController();
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_ctrl.hasClients || widget.items.length < 2) return;
      _ctrl.animateToPage(
        (_index + 1) % widget.items.length,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.w(104),
          child: PageView.builder(
            controller: _ctrl,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(16)),
              child: _BannerCard(item: widget.items[i]),
            ),
          ),
        ),
        8.vGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: context.w(active ? 18 : 10),
              height: 3,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.chipBg,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final PromoBannerItem item;

  const _BannerCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: AppColors.primary,
        child: Stack(
          children: [
            // decorative yellow ring
            Positioned(
              top: -context.w(14),
              left: -context.w(14),
              child: Container(
                width: context.w(46),
                height: context.w(46),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondary, width: 7),
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: context.w(14)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.body(size: context.sp(11), color: AppColors.white, w: FontWeight.w600),
                          ),
                          4.vGap,
                          Text(item.discount, style: AppStyles.title(size: context.sp(24))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(context.w(60))),
                      child: FoodImage(src: item.image, radius: 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}