import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:your_advisor/UI/custom_widgets/custom_rounded_btn.dart';
import 'package:your_advisor/domain/app_routes.dart';

class BeforeVocationalTestPage extends StatelessWidget {
  const BeforeVocationalTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gap(80),
              Center(
                child: Text(
                  "Szukasz idealnego zawodu dla siebie?",
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
                    "Żeby poznać swój wymarzony zawód, poprosimy Cię o wypełnienie testu kompetencji zawodowych. Dzięki temu odrzucimy to, co nie pasuje Twoim predyspozycjom. Test zajmie do kilku minut.",
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
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_vocational);
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
