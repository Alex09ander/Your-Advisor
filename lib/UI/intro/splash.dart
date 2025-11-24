import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:your_advisor/domain/app_colors.dart';
import 'package:your_advisor/domain/app_routes.dart';
import 'package:your_advisor/domain/auth/user_repository.dart';
import 'package:your_advisor/domain/tests/test_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      try {
        final userId = context.read<UserRepository>().userId;
        bool userExists = userId != null;
        if (userExists) {
          final psychologyTest =
              await context.read<TestRepository>().psychologyTest(userId);
          final psychologyTestExists = psychologyTest != null;
          if (!mounted) {
            throw Exception("Context is not mounted");
          }
          if (psychologyTestExists) {
            Navigator.pushNamed(context, AppRoutes.menu_page);
          } else {
            Navigator.pushNamed(context, AppRoutes.test_psychology);
          }
        } else {
          Navigator.pushNamed(context, AppRoutes.start_page);
        }
      } catch (e) {
        Navigator.pushNamed(context, AppRoutes.start_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SvgPicture.asset(
          "assets/svg/Logo_test-removebg-preview.svg",
          width: 70,
        ),
      ),
    );
  }
}
