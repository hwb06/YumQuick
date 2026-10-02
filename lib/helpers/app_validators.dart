class AppValidators {
  AppValidators._();

  static String? required(String? v, [String field = 'This field']) =>
      (v == null || v.trim().isEmpty) ? '$field is required' : null;

  static String? fullName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Full name is required';
    if (v.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final ok = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  static String? emailOrMobile(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email or mobile is required';
    final t = v.trim();
    final isEmail = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$').hasMatch(t);
    final isPhone = RegExp(r'^\+?\d{10,14}$').hasMatch(t);
    return (isEmail || isPhone) ? null : 'Enter a valid email or mobile number';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'At least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Add an uppercase letter';
    if (!RegExp(r'\d').hasMatch(v)) return 'Add a number';
    return null;
  }

  static String? mobile(String? v) {
    if (v == null || v.trim().isEmpty) return 'Mobile number is required';
    return RegExp(r'^\+?\d{10,14}$').hasMatch(v.trim())
        ? null
        : 'Enter a valid mobile number';
  }

  static String? dob(String? v) =>
      (v == null || v.isEmpty) ? 'Date of birth is required' : null;
}