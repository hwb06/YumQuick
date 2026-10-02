import 'package:flutter/material.dart';

// // String Extensions
// extension StringExtensions on String {
//   // Email validation extension
//   bool get isValidEmail {
//     final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     return emailRegExp.hasMatch(this);
//   }
//
//   // Password validation extension
//   bool get isValidPassword {
//     return this.length >= 6;
//   }
//
//   // Checks if string is empty or null
//   bool get isNullOrEmpty {
//     return this.isEmpty;
//   }
//
//   // Capitalizes first letter of the string
//   String get capitalizeFirst {
//     if (this.isEmpty) return this;
//     return this[0].toUpperCase() + this.substring(1);
//   }
// }
//
// // Context Extensions
// extension ContextExtensions on BuildContext {
//   // Show snackbar extension
//   void showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // Get screen size extension
//   Size get screenSize => MediaQuery.of(this).size;
//
//   // Get screen width extension
//   double get screenWidth => MediaQuery.of(this).size.width;
//
//   // Get screen height extension
//   double get screenHeight => MediaQuery.of(this).size.height;
//
//   // Navigate to screen extension
//   void navigateTo(Widget screen) {
//     Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
//   }
//
//   // Navigate and replace current screen extension
//   void navigateAndReplace(Widget screen) {
//     Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => screen));
//   }
// }



extension ResponsiveContext on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  double get screenW => _size.width;
  double get screenH => _size.height;

  /// scale width/size relative to Figma frame (375)
  double w(double v) => v * (screenW / 375);

  /// scale height relative to Figma frame (812)
  double h(double v) => v * (screenH / 812);

  /// font/icon scale with a clamp so tablets don't explode
  double sp(double v) => v * (screenW / 375).clamp(0.85, 1.3);

  bool get isTablet => screenW >= 600;
}

extension PriceFormat on double {
  String get priceLabel =>
      this == roundToDouble() ? toStringAsFixed(1) : toStringAsFixed(2);
}

extension SpaceNum on num {
  SizedBox get vGap => SizedBox(height: toDouble());
  SizedBox get hGap => SizedBox(width: toDouble());
}