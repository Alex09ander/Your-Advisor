import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:your_advisor/UI/intro/splash.dart';
import 'package:your_advisor/UI/intro/start.dart';
import 'package:your_advisor/UI/pages/before_vocational_test_page.dart';
import 'package:your_advisor/UI/pages/career_advice_page.dart';
import 'package:your_advisor/UI/pages/test_page_psychology.dart';
import 'package:your_advisor/UI/pages/advice_page.dart';
import 'package:your_advisor/UI/pages/test_page_vocational.dart';
import 'package:your_advisor/domain/auth/user_repository.dart';

import '../UI/main_page/menu.dart';

class AppRoutes {
  static const String splash_page = '/splash';
  static const String start_page = '/start';
  static const String test_psychology = '/test_psychology';
  static const String before_test_vocational = '/before_test_vocational';
  static const String test_vocational = '/test_vocational';
  static const String menu_page = '/menu';
  static const String advice = '/advice';
  static const String career_advice = '/career_advice';

  static Map<String, Widget Function(BuildContext)> getRoutes() => {
        splash_page: (context) => const SplashPage(),
        start_page: (context) => const StartPage(),
        test_psychology: (context) => TestPage(),
        test_vocational: (context) => TestPageVocational(),
        before_test_vocational: (context) => const BeforeVocationalTestPage(),
        menu_page: (context) => const MenuPage(),
        advice: (context) => const AdvicePage(),
        career_advice: (context) {
          final userId = context.read<UserRepository>().userId!;
          return CareerAdvicePage(userId: userId);
        }
      };
}
