import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';
import 'package:your_advisor/domain/backend.dart';
import '../../domain/app_routes.dart';
import '../custom_widgets/custom_rounded_btn.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  final myController = TextEditingController();

  // ---------------------------------------
  // PYTANIA
  // ---------------------------------------
  final List<String> questions = [
    "Pasuje mi bycie w centrum zainteresowania",
    "Łatwo dogaduje się z nowymi osobami",
    "Muszę zaplanować pracę przed jej rozpoczęciem",
    "Mam problem z dotrzymywaniem terminów",
    "W sporze ważniejsze są uczucia, niż dotarcie do prawdy",
    "Jestem bezkompromisowy i walczę o swoje",
    "Miewam częste wahania nastroju",
    "Dobrze radzę sobie z emocjami",
    "Nie mam problemu z uzależnieniami",
    "Lubię nieszablonowe rozwiązania",
    "Mam predyspozycje do bycia artystą",
    "Swoje działania kieruję rozumem i logicznym myśleniem, bardziej niż emocjami",
    "Jestem w stanie w coś uwierzyć, dając się swoim emocjom",
    "Trudno mi utrzymać uwagę na jednej rzeczy",
    "Często zmieniam kierunek działania",
    "Grupa często widzi we mnie lidera",
    "Uważam że byłbym dobrym dyrektorem albo przywódcą politycznym",
    "Czego brakuje ci do pełni szczęścia?",
    "Jaki byłby twój wymarzony partner życiowy?",
    "Jaki byłby Twój wymarzony dzień?",
    "Czego w życiu najbardziej się boisz?"
  ];

  // ---------------------------------------
  // ODPOWIEDZI
  // ---------------------------------------
  List<int> closed = List.filled(17, 0); // 0–16 zamknięte
  List<String> open = List.filled(4, ""); // 17–20 otwarte

  int index = 0; // aktualne pytanie
  int selected = 0; // wybrana odpowiedź dla zamkniętych

  @override
  Widget build(BuildContext context) {
    final bool isOpen = index >= 17;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            ProgressBar(progress: (index / 21) * 350),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 120,
              width: 400,
              child: Text(
                questions[index],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 10),
            isOpen ? buildOpenInput() : buildClosedOptions(),
            buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------
  // INPUT OTWARTY
  // ---------------------------------------
  Widget buildOpenInput() {
    return Container(
      width: 400,
      child: TextField(
        controller: myController,
        minLines: 5,
        maxLines: 10,
        decoration: InputDecoration(labelText: "Wprowadź odpowiedź"),
      ),
    );
  }

  // ---------------------------------------
  // OPCJE ZAMKNIĘTE
  // ---------------------------------------
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
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          for (int i = 0; i < 7; i++) ...[
            Row(
              children: [
                CustomCircleBtn(
                  onTap: () {
                    setState(() {
                      selected = selected == i + 1 ? 0 : i + 1;
                    });
                  },
                  bgColor: i < 3
                      ? AppColors.greenColor
                      : i == 3
                          ? AppColors.greyColor
                          : AppColors.purpleColor,
                  mRadius: 50,
                  // mRadius: 70 - i * 10,
                  isOutlined: selected != i + 1,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Text(
                    labels[i],
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ]
        ],
      ),
    );
  }

  // ---------------------------------------
  // PRZYCISKI DÓŁ
  // ---------------------------------------
  Widget buildBottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // WRÓĆ
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
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

        // DALEJ / ZAKOŃCZ
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: CustomRoundedBtn(
            text: index == 20 ? "Zakończ" : "Dalej",
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

  // ---------------------------------------
  // LOGIKA "DALEJ"
  // ---------------------------------------
  void next() {
    // zamknięte
    if (index < 17) {
      if (selected == 0) return;
      closed[index] = selected;
      selected = 0;
      goNext();
      return;
    }

    // otwarte
    if (myController.text.isEmpty) return;

    open[index - 17] = myController.text;
    myController.clear();
    goNext();
  }

  void goNext() {
    if (index == 20) {
      sendData();
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.menu_page);
      return;
    }

    setState(() {
      index++;
    });
  }

  // ---------------------------------------
  // LOGIKA "WRÓĆ"
  // ---------------------------------------
  void back() {
    if (index == 0) {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.start_page);
      return;
    }

    if (index < 17) {
      closed[index] = 0;
      selected = 0;
    } else {
      open[index - 17] = "";
      myController.clear();
    }

    setState(() {
      index--;
    });
  }

  void sendData() async {
    final payload = TestPayload(
      userId: Supabase
          .instance.client.auth.currentUser!.id, // tutaj ID usera z Twojej aplikacji
      closedAnswers: closed,
      openAnswers: open,
    );

    try {
      final response = await submitPsychologyTest(payload);
      print("OK: $response");
    } catch (e) {
      print("ERR: $e");
    }
  }
}
