import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();

  @override
  void dispose() {
    for (final c in [_nameCtrl, _pwdCtrl, _emailCtrl, _mobileCtrl, _dobCtrl]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1940),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final d = picked.day.toString().padLeft(2, '0');
      final m = picked.month.toString().padLeft(2, '0');
      _dobCtrl.text = '$d / $m / ${picked.year}';
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created! Please log in.')),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: AppStrings.newAccount,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: AppStrings.fullName,
              hint: 'John Doe',
              controller: _nameCtrl,
              validator: AppValidators.fullName,
            ),
            12.vGap,
            AppTextField(
              label: AppStrings.password,
              hint: '••••••••',
              controller: _pwdCtrl,
              isPassword: true,
              validator: AppValidators.password,
            ),
            12.vGap,
            AppTextField(
              label: AppStrings.email,
              hint: 'example@example.com',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email,
            ),
            12.vGap,
            AppTextField(
              label: AppStrings.mobile,
              hint: '+123 456 789',
              controller: _mobileCtrl,
              keyboardType: TextInputType.phone,
              formatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
              validator: AppValidators.mobile,
            ),
            12.vGap,
            AppTextField(
              label: AppStrings.dob,
              hint: 'DD / MM / YYYY',
              controller: _dobCtrl,
              readOnly: true,
              onTap: _pickDob,
              action: TextInputAction.done,
              validator: AppValidators.dob,
            ),
            context.h(16).vGap,
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'By continuing, you agree to\n',
                  style: AppStyles.body(size: context.sp(9), color: AppColors.textGrey),
                  children: [
                    TextSpan(text: 'Terms of Use', style: AppStyles.link(size: context.sp(9))),
                    const TextSpan(text: ' and '),
                    TextSpan(text: 'Privacy Policy.', style: AppStyles.link(size: context.sp(9))),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            12.vGap,
            Center(child: AppButton(label: AppStrings.signUp, onPressed: _submit)),
            12.vGap,
            const Center(child: SocialRow()),
            12.vGap,
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
                child: Text.rich(
                  TextSpan(
                    text: AppStrings.haveAccount,
                    style: AppStyles.body(size: context.sp(10), color: AppColors.textGrey),
                    children: [TextSpan(text: AppStrings.logIn, style: AppStyles.link(size: context.sp(10)))],
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