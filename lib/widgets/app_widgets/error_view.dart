import 'package:flutter/material.dart';
import 'package:yum_quick/widgets/app_widgets/app_buttons.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';


class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.wifi_off_rounded, size: context.w(48), color: AppColors.primary),
            12.vGap,
            Text(message, textAlign: TextAlign.center, style: AppStyles.body(size: context.sp(14))),
            16.vGap,
            AppButton(label: 'Retry', width: 120, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}