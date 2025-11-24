import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/intro/splash.dart';
import 'package:your_advisor/UI/theme/app_theme.dart';
import 'package:your_advisor/UI/theme/flutter_theme_creator.dart';
import 'package:your_advisor/domain/auth/guest_auth_service.dart';
import 'package:your_advisor/domain/auth/supabase_user_repository.dart';
import 'package:your_advisor/domain/auth/user_repository.dart';
import 'package:your_advisor/domain/career_advice/backend_career_advice_api.dart';
import 'package:your_advisor/domain/career_advice/career_advice_api.dart';
import 'package:your_advisor/domain/career_advice/mock_career_advice_api.dart';
import 'package:your_advisor/domain/tests/backend_tests_repository.dart';
import 'package:your_advisor/domain/tests/test_repository.dart';

import 'domain/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://jbxgzhiiiifqqiwoqmzr.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpieGd6aGlpaWlmcXFpd29xbXpyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4MDY1MDAsImV4cCI6MjA3ODM4MjUwMH0.6cnrkL1Ep3wFV7-wEV7xSP4qTISGPVODygpxnpTqoBU");

  // final authService = GuestAuthService(Supabase.instance.client);
  // try {
  //   await authService.ensureSignedInAsGuest();
  // } catch (e) {
  //   if (e.toString().contains("invalid_credentials")) {
  //     await authService.resetGuestOnThisDevice();
  //     await authService.ensureSignedInAsGuest();
  //   }
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData flutterTheme = FlutterThemeCreator()
        .createFlutterTheme(const AppTheme(isDark: false, accessibilityModeIsOn: false));

    return MultiProvider(
      providers: [
        Provider<TestRepository>(
          create: (context) {
            return BackendTestsRepository();
          },
        ),
        Provider<UserRepository>(
          create: (context) {
            return SupabaseUserRepository();
          },
        ),
        Provider<CareerAdviceApi>(create: (context) {
          return BackendCareerAdviceApi();
          // return MockCareerAdviceApi();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: flutterTheme,
        home: const SplashPage(),
        routes: AppRoutes.getRoutes(),
        initialRoute: AppRoutes.splash_page,
      ),
    );
  }
}
