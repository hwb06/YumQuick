import 'package:flutter/material.dart';
import '../presentation/splash_screens.dart';
import '../presentation/welcome_screen.dart';
import '../presentation/login_screen.dart';
import '../presentation/signup_screen.dart';
import '../presentation/home_screen.dart';
import '../presentation/category_screen.dart';
import '../presentation/details_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const category = '/category';
  static const details = '/details';

  static Route<dynamic> onGenerateRoute(RouteSettings s) {
    switch (s.name) {
      case splash:
        return _page(const SplashScreen(), s);
      case welcome:
        return _page(const WelcomeScreen(), s);
      case login:
        return _page(const LoginScreen(), s);
      case signup:
        return _page(const SignupScreen(), s);
      case home:
        return _page(const HomeScreen(), s);
      case category:
        return _page(CategoryScreen(initialCategoryId: s.arguments as String), s);
      case details:
        return _page(DetailsScreen(foodId: s.arguments as String), s);
      default:
        return _page(
          const Scaffold(body: Center(child: Text('Route not found'))),
          s,
        );
    }
  }

  static MaterialPageRoute _page(Widget w, RouteSettings s) =>
      MaterialPageRoute(builder: (_) => w, settings: s);
}