import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_advisor/UI/custom_widgets/custom_rounded_btn.dart';
import 'package:your_advisor/domain/app_routes.dart';

import '../../domain/app_colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center (
        child: Column(
            children: [
              Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Text(
                        "Test profilu psychologicznego",
                        style: TextStyle(
                            fontFamily: 'PatrickHand',
                            color: AppColors.textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  )
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 1000,
                    height: 600,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Text(
                          "Ten test polega na ocenie zdolności poznawczych (takich jak pamięć, uwaga, myślenie logiczne) poprzez rozwiązanie serii zadań o rosnącym stopniu trudności.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'PatrickHand',
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          )
                      ),
                    ),

                  )
                ],
              ),
              CustomRoundedBtn(
                text: "Przejdź do testu",
                fontSize: 20,
                mWidth: 350,
                textColor: AppColors.text2Color,
                bgColor: AppColors.thirdColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_page);
                },
              ),
              SizedBox(height: 20,),
              CustomRoundedBtn(
                text: "Zaloguj z Google",
                fontSize: 20,
                mIconPath: "assets/svg/Google_Favicon_2025.svg",
                iconColor: AppColors.text2Color,
                mWidth: 350,
                textColor: AppColors.text2Color,
                bgColor: AppColors.secondaryColor,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_page);
                },
              ),
            ],

        ),
      ),

    );
  }
}
