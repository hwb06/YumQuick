import 'package:flutter/material.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const AuthScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final bottomSafe = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: context.h(keyboardOpen ? 56 : 90),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.only(left: context.pagePad - 4),
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.primary, size: 16),
                    ),
                  ),
                  Text(title, style: AppStyles.title(size: context.sp(24))),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(
                    context.pagePad + 8,
                    context.h(24),
                    context.pagePad + 8,
                    context.h(24) + bottomSafe + 24, // keyboard/gesture bar ke liye extra
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}