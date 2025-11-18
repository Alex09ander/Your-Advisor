import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:your_advisor/UI/custom_widgets/main_page/main_button.dart';
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
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/svg/Logo_test-removebg-preview.svg",
                width: 70,
              ),
            ),
            Gap(50),
            MainButton(
              titleText: "Otrzymaj wsparcie",
              contentText:
                  "Męczy Cię jakaś sprawa? Czujesz się przytłoczony? Zagubiłeś się i chcesz o tym pogadać? Nasz Asystent jest do Twojej dyspozycji.",
              assetImagePath: "assets/icon/psychology.png",
              onPressed: () {
                Navigator.of(context).pushNamed('/advice');
              },
            ),
            // Divider(
            //   height: 30,
            //   thickness: 2,
            // ),
            Gap(60),
            MainButton(
              titleText: "Znajdź wymarzony zawód",
              contentText:
                  "Czujesz, że stoisz w tyle? Boisz się o pracę po studiach? Twój wybór okazał się nietrafiony? Nasz Asystent odnajdzie zawód pasujący do Twojej osobowości.",
              assetImagePath: "assets/icon/goal.png",
              onPressed: () {
                Navigator.of(context).pushNamed('/advice');
              },
            ),
          ],
        ),
      ),
    );
  }
}
