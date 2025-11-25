import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';
import 'package:your_advisor/domain/backend.dart';
import '../../domain/app_routes.dart';

class TestPageVocational extends StatefulWidget {
  @override
  State<TestPageVocational> createState() => TestPageVocationalState();
}

class TestPageVocationalState extends State<TestPageVocational> {
  final myController = TextEditingController();

  final List<String> questions = [
    "Dobrze odnajduję się w pracy grupowej",
    "Efektywniej pracuję, jeśli jestem sam",
    "Lubię wykonywać drobne naprawy i prace manualne",
    "Lubię / lubiłem pisać rozprawki lub prace naukowe",
    "Jestem zaawansowany w ogólnej obsłudze komputera",
    "Mam wyczucie estetyki",
    "Lubię wyrażać swoją opinię",
    "Regularnie obcuję ze sztuką",
    "Umiem myśleć algorytmicznie",
    "Lubię rozwiązywać złożone problemy",
    "Chcę tworzyć coś dla innych użytkowników",
    "Szybko uczę się języków obcych",
    "Jestem sprawny fizycznie",
    "Cenię kontakt z naturą",
    "Szukam stabilności finansowej i bezpieczeństwa",
    "Preferuję pracę zdalną",
    "Unikam wystąpień publicznych",
    "Bardzo cenię aspekt finansowy pracy",
    "Chcę, by praca rozwijała mnie nawet kosztem zarobków",
    "Dobrze wyciągam wnioski na podstawie danych",
    "Interesuję się anatomią i medycyną",
    "Mam dobrą pamięć do pojęć",
    "Lubię brać udział w projektach grupowych",

    // otwarte
    "Opisz sytuację z pracy, która dała Ci największą satysfakcję",
    "Jakie umiejętności lub wiedzę chcesz rozwijać?",
    "Czego unikasz lub się obawiasz w pracy?",
    "Jak praca ma wpływać na Twoje życie prywatne?"
  ];

  // -------------------------------------------------------------------
  // ODPOWIEDZI
  // -------------------------------------------------------------------
  List<int> closed = List.filled(23, 0);
  List<String> open = List.filled(4, "");

  int questionIndex = 0;
  int selectedAnswer = 0;
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final bool isOpen = questionIndex >= 23;

    if (_sending) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: _buildSendingState(context),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            ProgressBar(progress: (questionIndex / 27) * 350),
            Gap(30),
            Spacer(),
            Text(
              questions[questionIndex],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap(30),
            isOpen ? buildOpenInput() : buildClosedOptions(),
            Spacer(),
            buildBottomButtons(),
            Gap(40)
          ],
        ),
      ),
    );
  }

  Widget _buildSendingState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: 0.92 + value * 0.08,
              child: child,
            ),
          );
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: colors.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 36, 32, 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 42,
                  height: 42,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation(colors.primary),
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'Przetwarzam odpowiedzi…',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Tworzę dla Ciebie profil zawodowy. Zajmie to kilka sekund.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOpenInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        child: TextField(
          controller: myController,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(labelText: "Wprowadź odpowiedź"),
        ),
      ),
    );
  }

  Widget buildClosedOptions() {
    final labels = [
      "Zdecydowanie się zgadzam",
      "Zgadzam się",
      "Trochę się zgadzam",
      "Nie mam zdania",
      "Trochę się nie zgadzam",
      "Nie zgadzam się",
      "Zdecydowanie się nie zgadzam"
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          for (int i = 0; i < 7; i++) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(60),
                onTap: () {
                  setState(() {
                    selectedAnswer = selectedAnswer == i + 1 ? 0 : i + 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      CustomCircleBtn(
                        onTap: () {
                          setState(() {
                            selectedAnswer = selectedAnswer == i + 1 ? 0 : i + 1;
                          });
                        },
                        bgColor: i < 3
                            ? AppColors.greenColor
                            : i == 3
                                ? AppColors.greyColor
                                : AppColors.purpleColor,
                        mRadius: 50,
                        isOutlined: selectedAnswer != i + 1,
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Text(
                          labels[i],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
          ]
        ],
      ),
    );
  }

  Widget buildBottomButtons() {
    final cs = Theme.of(context).colorScheme;
    final isLast = questionIndex == questions.length - 1;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // WRÓĆ — OutlinedButton
          SizedBox(
            width: 160,
            height: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.onSurfaceVariant,
                side: BorderSide(color: cs.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: back,
              child: const Text(
                "Wróć",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          const SizedBox(width: 20),

          // DALEJ / ZAKOŃCZ — FilledButton
          SizedBox(
            width: 160,
            height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: cs.primaryContainer,
                foregroundColor: cs.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: next,
              child: Text(
                isLast ? "Zakończ" : "Dalej",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void next() {
    if (questionIndex < 23) {
      if (selectedAnswer == 0) return;
      closed[questionIndex] = selectedAnswer;
      selectedAnswer = 0;
      goNext();
    } else {
      if (myController.text.isEmpty) return;
      open[questionIndex - 23] = myController.text;
      myController.clear();
      goNext();
    }
  }

  Future<void> goNext() async {
    if (questionIndex == 26) {
      setState(() => _sending = true);

      final ok = await sendData();

      if (!mounted) return;

      if (!ok) {
        setState(() => _sending = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nie udało się zapisać testu.")),
        );
        return;
      }

      await Future.delayed(const Duration(milliseconds: 300));

      Navigator.pushReplacementNamed(context, AppRoutes.career_advice);
      return;
    }
    setState(() => questionIndex++);
  }

  Future<bool> sendData() async {
    final payload = TestPayload(
      userId: Supabase
          .instance.client.auth.currentUser!.id, // tutaj ID usera z Twojej aplikacji
      closedAnswers: closed,
      openAnswers: open,
    );

    try {
      final response = await submitVocationalTest(payload);
      print("OK: $response");
      return true;
    } catch (e) {
      print("ERR: $e");
      return false;
    }
  }

  void back() {
    if (questionIndex == 0) {
      Navigator.pushNamed(context, AppRoutes.menu_page);
      return;
    }

    if (questionIndex < 23) {
      closed[questionIndex] = 0;
      selectedAnswer = 0;
    } else {
      open[questionIndex - 23] = "";
      myController.clear();
    }

    setState(() => questionIndex--);
  }
}
