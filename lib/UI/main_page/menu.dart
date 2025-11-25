import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:your_advisor/domain/app_routes.dart';
import 'package:your_advisor/domain/auth/user_repository.dart';
import 'package:your_advisor/domain/tests/test_repository.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(16),
                      SvgPicture.asset(
                        "assets/svg/Logo_test-removebg-preview.svg",
                        width: 90,
                      ),
                      Gap(32),
                      Text(
                        "W czym mogę pomóc?",
                        style: text.headlineMedium?.copyWith(
                          color: colors.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(32),
                      _MenuCard(
                        iconPath: "assets/icon/psychology.png",
                        title: "Otrzymaj wsparcie",
                        description:
                            "Czujesz ciężar na barkach? Nie wiesz, co dalej? Asystent wysłucha i przeprowadzi Cię przez trudniejszy moment.",
                        onPressed: () =>
                            Navigator.of(context).pushNamed(AppRoutes.advice),
                      ),
                      Gap(24),
                      _MenuCard(
                        iconPath: "assets/icon/goal.png",
                        title: "Znajdź wymarzony zawód",
                        description:
                            "Niepewność zawodowa? Zły kierunek? Asystent dobierze zawód dopasowany do Twojej osobowości.",
                        onPressed: () async {
                          final userId = context.read<UserRepository>().userId!;
                          final test =
                              await context.read<TestRepository>().vocationTest(userId);

                          if (test == null) {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.before_test_vocational);
                          } else {
                            Navigator.of(context).pushNamed(AppRoutes.career_advice);
                          }
                        },
                      ),
                      Gap(24),
                      _SecondaryMenuCard(
                        iconPath: "assets/icon/labor_market.png",
                        title: "Sprawdź sytuację na rynku pracy",
                        description:
                            "Które zawody są obecnie popytowe? Jaki zawód będzie miał łatwo za 5 lat?",
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const _MenuCard({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      color: colors.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    iconPath,
                    width: 54,
                    height: 54,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: Text(
                    title,
                    style: text.titleLarge?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            Gap(14),
            Text(
              description,
              style: text.bodyMedium?.copyWith(
                height: 1.35,
                color: colors.onSurfaceVariant,
              ),
            ),
            Gap(20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPressed,
                child: const Text("Przejdź"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondaryMenuCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const _SecondaryMenuCard({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colors.surfaceContainerLow, // subtelnie
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    iconPath,
                    width: 42,
                    height: 42,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: text.bodySmall?.copyWith(
                height: 1.35,
                color: colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.onSurfaceVariant,
                  side: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.6)),
                ),
                child: const Text("Przejdź"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _SecondaryMenuCard extends StatelessWidget {
//   final String iconPath;
//   final String title;
//   final String description;
//   final VoidCallback onPressed;

//   const _SecondaryMenuCard({
//     required this.iconPath,
//     required this.title,
//     required this.description,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     final text = Theme.of(context).textTheme;

//     return Card(
//       elevation: 1,
//       color: colors.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(14),
//                   child: Image.asset(
//                     iconPath,
//                     width: 40,
//                     height: 40,
//                   ),
//                 ),
//                 Gap(16),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: text.titleMedium?.copyWith(
//                       color: colors.onSurface,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Gap(14),
//             Text(
//               description,
//               style: text.bodyMedium?.copyWith(
//                 height: 1.35,
//                 color: colors.onSurfaceVariant,
//               ),
//             ),
//             Gap(20),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: onPressed,
//                 child: const Text("Przejdź"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
