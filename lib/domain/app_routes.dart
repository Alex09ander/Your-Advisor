import 'package:flutter/cupertino.dart';
import 'package:your_advisor/UI/intro/splash.dart';
import 'package:your_advisor/UI/intro/start.dart';
import 'package:your_advisor/UI/intro/test_page_psychology.dart';
import 'package:your_advisor/UI/pages/advice_page.dart';
import 'package:your_advisor/UI/pages/test_page_profession.dart';

import '../UI/main_page/menu.dart';

class AppRoutes {
  static const String splash_page = '/splash';
  static const String start_page = '/start';
  static const String test_page = '/test';
  static const String test_prof_page = '/testProf';
  static const String menu_page = '/menu';
  static const String advice_page = '/advice';

  static Map<String, Widget Function(BuildContext)> getRoutes() => {
        splash_page: (context) => const SplashPage(),
        start_page: (context) => const StartPage(),
        test_page: (context) => TestPage(),
        test_prof_page: (context) => TestPageProfession(),
        menu_page: (context) => const MenuPage(),
        advice_page: (context) => const AdvicePage()
      };
}
