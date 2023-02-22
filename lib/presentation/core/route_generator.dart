import 'package:flutter/material.dart';
import 'package:icare_pro/presentation/core/routes.dart';
import 'package:icare_pro/presentation/home/pages/tab_appointment_page.dart';
import 'package:icare_pro/presentation/onboarding/pages/forgot_password_page.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordPage(),
        );
      case AppRoutes.tabAppointment:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TabAppointmentPage(),
        );
    }
    return null;
  }
}
