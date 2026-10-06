import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helpers/app_assets.dart';
import '../../helpers/app_colors.dart';
import '../../helpers/app_extensions.dart';
import '../../helpers/app_styles.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction action;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatters;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.action = TextInputAction.next,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.formatters,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure = widget.isPassword;

  OutlineInputBorder _border([Color c = Colors.transparent]) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: c, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppStyles.heading(size: context.sp(14))),
        6.vGap,
        TextFormField(
          controller: widget.controller,
          scrollPadding: const EdgeInsets.only(bottom: 140),
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.action,
          obscureText: _obscure,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          inputFormatters: widget.formatters,
          style: AppStyles.body(size: context.sp(13)),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppStyles.body(size: context.sp(13), color: AppColors.textGrey),
            filled: true,
            fillColor: AppColors.inputFill,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.w(14),
              vertical: context.w(12),
            ),
            errorStyle: AppStyles.body(size: context.sp(10), color: AppColors.error),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Image.asset(
                AppAssets.showPwd,
                width: context.w(18),
                errorBuilder: (_, __, ___) => Icon(
                  _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.primary,
                  size: context.w(18),
                ),
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
} 