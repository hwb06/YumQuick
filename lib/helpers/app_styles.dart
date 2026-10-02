import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  static TextStyle logo({Color color = AppColors.white, double size = 22}) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.w800, color: color);

  static TextStyle title({double size = 24, Color color = AppColors.white}) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.w700, color: color);

  static TextStyle heading({double size = 18}) =>
      GoogleFonts.josefinSans(fontSize: size, fontWeight: FontWeight.w700, color: AppColors.textDark);

  static TextStyle body({double size = 12, Color color = AppColors.textDark, FontWeight w = FontWeight.w500}) =>
      GoogleFonts.josefinSans(fontSize: size, fontWeight: w, color: color);

  static TextStyle link({double size = 12}) =>
      GoogleFonts.josefinSans(fontSize: size, fontWeight: FontWeight.w600, color: AppColors.primary);

  static TextStyle button({double size = 16}) =>
      GoogleFonts.josefinSans(fontSize: size, fontWeight: FontWeight.w700, color: AppColors.white);
}