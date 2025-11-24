import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/custom_rounded_btn.dart';
import 'package:your_advisor/domain/app_routes.dart';
import 'package:your_advisor/domain/auth/guest_auth_service.dart';

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
                onTap: () async {
                  final guestAuth = GuestAuthService(Supabase.instance.client);

                  try {
                    await guestAuth.ensureSignedInAsGuest();
                  } catch (e) {
                    // Ostatnia deska ratunku – totalny reset + 2 podejście
                    try {
                      await guestAuth.resetGuestOnThisDevice();
                      await guestAuth.ensureSignedInAsGuest();
                    } catch (e2) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Nie udało się zalogować jako gość.")),
                      );
                      return;
                    }
                  }

                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.test_psychology);
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
                  Navigator.pushNamed(context, AppRoutes.menu_page);
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
