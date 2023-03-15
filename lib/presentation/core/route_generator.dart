import 'package:flutter/material.dart';
import 'package:icare_pro/domain/entities/user.dart';
import 'package:icare_pro/presentation/core/routes.dart';
import 'package:icare_pro/presentation/home/pages/tab_appointment_page.dart';
import 'package:icare_pro/presentation/onboarding/pages/forgot_password_page.dart';
import 'package:icare_pro/presentation/onboarding/pages/tabbar_entry.dart';
import 'package:icare_pro/presentation/profile/pages/about_page.dart';
import 'package:icare_pro/presentation/profile/pages/edit_personal_details_page.dart';
import 'package:icare_pro/presentation/profile/pages/help_page.dart';
import 'package:icare_pro/presentation/profile/pages/history_page.dart';
import 'package:icare_pro/presentation/profile/pages/personal_details_page.dart';
import 'package:icare_pro/presentation/profile/pages/profile_page.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.tabEntry:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TabbarEntryPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPasswordPage(),
        );
      case AppRoutes.tabAppointment:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TabAppointmentPage(),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfilePage(),
        );
      case AppRoutes.personalDetails:
        return MaterialPageRoute(
          builder: (BuildContext context) => const PersonalDetailsPage(),
        );
      case AppRoutes.editPersonalDetails:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              EditPersonalDetailsPage(getProfileDetails: args as Future<User>?),
        );
      case AppRoutes.history:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HistoryPage(),
        );
      case AppRoutes.about:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AboutPage(),
        );
      case AppRoutes.helpPage:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HelpPage(),
        );
    }
    return null;
  }
}
