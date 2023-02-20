import 'package:flutter/material.dart';
import 'package:icare_pro/presentation/core/routes.dart';
import 'package:icare_pro/presentation/home/pages/home_page.dart';
import 'package:icare_pro/presentation/onboarding/pages/forgot_password_page.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NotificationsPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordPage(),
        );
    }
  }
}
