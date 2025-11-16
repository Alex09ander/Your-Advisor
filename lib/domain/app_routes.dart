import 'package:flutter/cupertino.dart';
import 'package:your_advisor/UI/intro/splash.dart';
import 'package:your_advisor/UI/intro/start.dart';
import 'package:your_advisor/UI/intro/test_page.dart';

import '../UI/main_page/menu.dart';

class AppRoutes{
  static const String splash_page = '/splash';
  static const String start_page = '/start';
  static const String test_page = '/test';
  static const String menu_page = '/menu';

  static Map<String, Widget Function(BuildContext)> getRoutes() => {
    splash_page : (contex) => SplashPage(),
    start_page : (contex) => StartPage(),
    test_page : (contex) => TestPage(),
    menu_page : (contex) => MenuPage(),
  };
}