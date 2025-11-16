import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_advisor/domain/app_colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/svg/Logo_test-removebg-preview.svg", width: 70,),
            )
          ],
        ),
      ),
    );
  }
}
