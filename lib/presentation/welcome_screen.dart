import 'package:flutter/material.dart';
import '../helpers/app_assets.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_extensions.dart';
import '../helpers/app_routes.dart';
import '../helpers/app_strings.dart';
import '../helpers/app_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logoYellow, width: context.w(270)),
              8.vGap,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(40)),
                child: Text(
                  AppStrings.welcomeMsg,
                  textAlign: TextAlign.center,
                  style: AppStyles.body(
                    size: context.sp(11),
                    color: AppColors.white,
                    w: FontWeight.w600,
                  ),
                ),
              ),
              context.h(48).vGap,
              _AuthButton(
                label: AppStrings.logIn,
                backgroundColor: AppColors.secondary,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              ),
              8.vGap,
              _AuthButton(
                label: AppStrings.signUp,
                backgroundColor: AppColors.secondaryLight,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const _AuthButton({
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.w(260),
      height: context.w(42),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(label, style: AppStyles.body(size: context.sp(17), color: AppColors.primary)),
      ),
    );
  }
}