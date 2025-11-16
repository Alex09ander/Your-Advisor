import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:your_advisor/UI/custom_widgets/custom_square_btn.dart';
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
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/svg/Logo_test-removebg-preview.svg", width: 70,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                  child: CustomSquareBtn(
                    text: "Tryb\npsychologa",
                    iconHeight: 100,
                    fontSize: 30,
                    sBoxSize: 50,
                    sBoxSize2: 20,
                    mIconPath: "assets/svg/Logo_test-removebg-preview.svg",
                    bgColor: AppColors.secondaryColor,
                    mHeight: 300,
                    mWidth: 180,
                    onTap: () {

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                  child: CustomSquareBtn(
                    text: "Tryb\ndoradcy",
                    iconHeight: 100,
                    fontSize: 30,
                    sBoxSize: 50,
                    sBoxSize2: 20,
                    mIconPath: "assets/svg/Logo_test-removebg-preview.svg",
                    bgColor: AppColors.secondaryColor,
                    mHeight: 300,
                    mWidth: 180,
                    onTap: () {

                    },
                  ),
                )


              ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                    child: CustomSquareBtn(
                      text: "Inny\ntryb",
                      iconHeight: 100,
                      fontSize: 30,
                      sBoxSize: 50,
                      sBoxSize2: 20,
                      mIconPath: "assets/svg/Logo_test-removebg-preview.svg",
                      bgColor: AppColors.secondaryColor,
                      mHeight: 300,
                      mWidth: 180,
                      onTap: () {

                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
                    child: CustomSquareBtn(
                      text: "Inny\ntryb",
                      iconHeight: 100,
                      fontSize: 30,
                      sBoxSize: 50,
                      sBoxSize2: 20,
                      mIconPath: "assets/svg/Logo_test-removebg-preview.svg",
                      bgColor: AppColors.secondaryColor,
                      mHeight: 300,
                      mWidth: 180,
                      onTap: () {

                      },
                    ),
                  )


                ]
            )
          ],
        ),
      ),
    );
  }
}
