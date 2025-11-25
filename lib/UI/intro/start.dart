import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/accessibility_positioned_overlay.dart';
import 'package:your_advisor/UI/custom_widgets/custom_rounded_btn.dart';
import 'package:your_advisor/domain/app_routes.dart';
import 'package:your_advisor/domain/auth/guest_auth_service.dart';

import '../../domain/app_colors.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Gap(80),
                  Center(
                    child: Text(
                      "Poznajmy się!",
                      style: Theme.of(context).textTheme.headlineMedium,
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
                      "Poprosimy Cię o wypełnienie testu psychologicznego...",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
                  const Gap(15),
                  const Spacer(),
                  CustomRoundedBtn(
                    text: "Rozpocznij",
                    fontSize: 20,
                    mWidth: 350,
                    bgColor: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: () async {
                      final guestAuth = GuestAuthService(Supabase.instance.client);
                      try {
                        await guestAuth.ensureSignedInAsGuest();
                      } catch (e) {
                        try {
                          await guestAuth.resetGuestOnThisDevice();
                          await guestAuth.ensureSignedInAsGuest();
                        } catch (_) {
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
                    bgColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    textColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  Gap(40),
                ],
              ),
            ),
          ),
          const AccessibilityOverlay(),
        ],
      ),
    );
  }
}
