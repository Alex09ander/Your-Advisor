import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:your_advisor/UI/custom_widgets/custom_rounded_btn.dart';
import 'package:your_advisor/domain/app_routes.dart';

import '../../domain/app_colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gap(80),
              Center(
                child: Text(
                  "Poznajmy się!",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const Spacer(),
              Image.asset(
                "assets/icon/quiz.png",
                height: 220,
                fit: BoxFit.fitHeight,
              ),
              Gap(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                    "Poprosimy Cię o wypełnienie testu psychologicznego. Dzięki temu poznamy Twoje mocne i słabe strony. Test nie powinien zająć dłużej niż 10 minut.",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!),
              ),
              const Gap(15),
              const Spacer(),
              CustomRoundedBtn(
                text: "Rozpocznij",
                fontSize: 20,
                mWidth: 350,
                // textColor: AppColors.text2Color,
                // bgColor: AppColors.thirdColor,
                bgColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_page);
                },
              ),
              Gap(20),
              CustomRoundedBtn(
                text: "Zaloguj z Google",
                fontSize: 20,
                mIconPath: "assets/svg/Google_Favicon_2025.svg",
                iconColor: AppColors.text2Color,
                mWidth: 350,
                // textColor: AppColors.text2Color,
                // bgColor: AppColors.secondaryColor,
                bgColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                textColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_page);
                },
              ),
              Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
