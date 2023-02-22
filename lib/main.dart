import 'package:flutter/material.dart';
import 'package:icare_pro/application/core/colors.dart';
import 'package:icare_pro/presentation/core/route_generator.dart';
import 'package:icare_pro/presentation/onboarding/pages/tabbar_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(
    showHome: showHome,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.showHome,
  });

  final bool showHome;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iCare Pro',
      theme: ThemeData(
        // is not restarted.
        primaryColor: AppColors.primaryColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: AppColors.whiteColor,
          secondary: AppColors.primaryColor,
          onSecondary: AppColors.whiteColor,
          error: AppColors.errorColor,
          onError: AppColors.whiteColor,
          background: AppColors.whiteColor,
          onBackground: AppColors.primaryColor,
          surface: AppColors.whiteColor,
          onSurface: AppColors.primaryColor,
        ),
      ),
      home: showHome ? const TabbarEntryPage() : const TabbarEntryPage(),
      onGenerateRoute: GenerateRoute.onGenerateRoute,
    );
  }
}
