import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';
import 'package:your_advisor/domain/backend.dart';
import '../../domain/app_routes.dart';
import '../custom_widgets/custom_rounded_btn.dart';

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

  @override
  Widget build(BuildContext context) {
    final bool isOpen = questionIndex >= 23;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ProgressBar(progress: (questionIndex / 27) * 350),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 120,
              width: 400,
              child: Text(
                questions[questionIndex],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            isOpen ? buildOpenInput() : buildClosedOptions(),
            buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildOpenInput() {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: myController,
        minLines: 5,
        maxLines: 10,
        decoration: const InputDecoration(labelText: "Wprowadź odpowiedź"),
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

    Color colorFor(int i) {
      if (i < 3) return AppColors.greenColor;
      if (i == 3) return AppColors.greyColor;
      return AppColors.purpleColor;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          for (int i = 0; i < 7; i++) ...[
            Row(
              children: [
                CustomCircleBtn(
                  onTap: () => setState(() {
                    selectedAnswer = selectedAnswer == i + 1 ? 0 : i + 1;
                  }),
                  bgColor: colorFor(i),
                  mRadius: 50,
                  isOutlined: selectedAnswer != i + 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(
                    labels[i],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: CustomRoundedBtn(
            text: "Wróć",
            fontSize: 20,
            mWidth: 160,
            mHeight: 80,
            isOutlined: true,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
            bgColor: Theme.of(context).colorScheme.surfaceContainer,
            onTap: back,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: CustomRoundedBtn(
            text: questionIndex == 26 ? "Zakończ" : "Dalej",
            fontSize: 20,
            mWidth: 160,
            mHeight: 80,
            textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            bgColor: Theme.of(context).colorScheme.primaryContainer,
            onTap: next,
          ),
        ),
      ],
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

  void goNext() {
    if (questionIndex == 26) {
      sendData();
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.career_advice);
      });
      return;
    }
    setState(() => questionIndex++);
  }

  void sendData() async {
    final payload = TestPayload(
      userId: Supabase
          .instance.client.auth.currentUser!.id, // tutaj ID usera z Twojej aplikacji
      closedAnswers: closed,
      openAnswers: open,
    );

    try {
      final response = await submitVocationalTest(payload);
      print("OK: $response");
    } catch (e) {
      print("ERR: $e");
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
