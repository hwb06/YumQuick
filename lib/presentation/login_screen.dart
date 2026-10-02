import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_extensions.dart';
import '../helpers/app_routes.dart';
import '../helpers/app_strings.dart';
import '../helpers/app_styles.dart';
import '../helpers/app_validators.dart';
import '../widgets/app_widgets/app_buttons.dart';
import '../widgets/app_widgets/app_text_field.dart';
import '../widgets/app_widgets/auth_scaffold.dart';
import '../widgets/app_widgets/social_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  @override
  void dispose() {
    _idCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // TODO: Firebase auth yahan aayega
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: AppStrings.logIn,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.welcome, style: AppStyles.heading(size: context.sp(20))),
            8.vGap,
            Text(
              AppStrings.loremShort,
              style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey),
            ),
            context.h(24).vGap,
            AppTextField(
              label: AppStrings.emailOrMobile,
              hint: 'example@example.com',
              controller: _idCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.emailOrMobile,
            ),
            16.vGap,
            AppTextField(
              label: AppStrings.password,
              hint: '••••••••',
              controller: _pwdCtrl,
              isPassword: true,
              action: TextInputAction.done,
              validator: AppValidators.password,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon with Firebase')),
                ),
                child: Text(AppStrings.forgotPassword, style: AppStyles.link(size: context.sp(11))),
              ),
            ),
            context.h(16).vGap,
            Center(child: AppButton(label: AppStrings.logIn, onPressed: _submit)),
            context.h(16).vGap,
            const Center(child: SocialRow()),
            context.h(16).vGap,
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.signup),
                child: Text.rich(
                  TextSpan(
                    text: AppStrings.noAccount,
                    style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey),
                    children: [TextSpan(text: AppStrings.signUp, style: AppStyles.link(size: context.sp(10)))],
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