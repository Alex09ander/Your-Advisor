import 'package:flutter/material.dart';
import 'package:your_advisor/UI/intro/splash.dart';
import 'package:your_advisor/UI/theme/app_theme.dart';
import 'package:your_advisor/UI/theme/flutter_theme_creator.dart';

import '../domain/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData flutterTheme = FlutterThemeCreator()
        .createFlutterTheme(const AppTheme(isDark: false, accessibilityModeIsOn: false));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: flutterTheme,
      home: const SplashPage(),
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.splash_page,
    );
  }
}
