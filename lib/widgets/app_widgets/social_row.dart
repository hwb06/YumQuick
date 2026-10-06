import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_strings.dart';
import '../../helpers/app_styles.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  static const double _tapSize = 48;
  static const double _circle = 38;
  Widget _btn(BuildContext context, IconData icon, String label) {
    return Semantics(
      button: true,
      label: label,
      child: InkResponse(
        radius: _tapSize / 2,
        onTap: () => ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$label: coming soon'))),
        child: SizedBox(
          width: _tapSize,
          height: _tapSize,
          child: Center(
            child: Container(
              width: _circle,
              height: _circle,
              decoration: const BoxDecoration(
                color: AppColors.peach,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.orSignUpWith,
          style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey),
        ),
        4.vGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _btn(context, Icons.g_mobiledata_rounded, 'Google'),
            _btn(context, Icons.facebook_rounded, 'Facebook'),
            _btn(context, Icons.fingerprint_rounded, 'Fingerprint'),
          ],
        ),
      ],
    );
  }
}