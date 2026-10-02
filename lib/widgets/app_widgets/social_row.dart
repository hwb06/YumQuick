import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_strings.dart';
import '../../helpers/app_styles.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  Widget _btn(BuildContext context, IconData icon) => Container(
    width: context.w(32),
    height: context.w(32),
    margin: EdgeInsets.symmetric(horizontal: context.w(6)),
    decoration: const BoxDecoration(color: AppColors.peach, shape: BoxShape.circle),
    child: Icon(icon, color: AppColors.primary, size: context.w(18)),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppStrings.orSignUpWith, style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey)),
        8.vGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn(context, Icons.g_mobiledata_rounded),
            _btn(context, Icons.facebook_rounded),
            _btn(context, Icons.fingerprint_rounded),
          ],
        ),
      ],
    );
  }
}