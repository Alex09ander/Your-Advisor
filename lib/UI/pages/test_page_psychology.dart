import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:your_advisor/UI/custom_widgets/custom_circle_btn.dart';
import 'package:your_advisor/UI/custom_widgets/progress_bar.dart';
import 'package:your_advisor/domain/app_colors.dart';
import 'package:your_advisor/domain/auth/guest_auth_service.dart';
import 'package:your_advisor/domain/backend.dart';
import '../../domain/app_routes.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Gap(70),
              ProgressBar(progress: (index / 21) * 350),
              Gap(30),
              Spacer(),
              // SizedBox(height: 20),
              Text(
                questions[index],
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
      ),
    );
  }

  // ---------------------------------------
  // INPUT OTWARTY
  // ---------------------------------------
  Widget buildOpenInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: TextField(
          controller: myController,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(labelText: "Wprowadź odpowiedź"),
        ),
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
      padding: const EdgeInsets.only(left: 25),
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
                    selected = selected == i + 1 ? 0 : i + 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
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
                        isOutlined: selected != i + 1,
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

  // ---------------------------------------
  // PRZYCISKI DÓŁ
  // ---------------------------------------
  Widget buildBottomButtons() {
    final cs = Theme.of(context).colorScheme;
    final isLast = index == questions.length - 1;

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

  // ---------------------------------------
  // LOGIKA "DALEJ"
  // ---------------------------------------
  Future<void> next() async {
    // zamknięte
    if (index < 17) {
      if (selected == 0) return;
      closed[index] = selected;
      selected = 0;
      await goNext();
      return;
    }

    // otwarte
    if (myController.text.isEmpty) return;

    open[index - 17] = myController.text;
    myController.clear();
    await goNext();
  }

  Future<void> goNext() async {
    if (index == 20) {
      try {
        sendData().then((sent) {
          if (!sent) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Wystąpił błąd: nie udało się zapisać Twojego testu.")));
          }
        });

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Dziękujemy za wypełnienie testu"),
              content: const Text(
                  "Po tym jak już znamy Twoją osobowość, możesz rozpocząć rozmowę z naszym Asystentem."),
              actions: [
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );

        if (!mounted) return;

        // dopiero potem przejście do menu
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.menu_page,
          (route) => false,
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Nie udało się wysłać testu: $e")),
        );
      }

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

  Future<bool> sendData() async {
    final client = Supabase.instance.client;

    var user = client.auth.currentUser;

    try {
      // jeśli z jakiegoś powodu user jest null (np. sesja nie weszła), spróbuj zalogować gościa
      if (user == null) {
        final guestAuth = GuestAuthService(client);
        await guestAuth.ensureSignedInAsGuest();
        user = client.auth.currentUser;
      }

      if (user == null) {
        throw Exception("Brak zalogowanego użytkownika (user == null)");
      }

      final payload = TestPayload(
        userId: user.id,
        closedAnswers: closed,
        openAnswers: open,
      );

      final response = await submitPsychologyTest(payload);
      debugPrint("Psychology test sent OK: $response");
      return true;
    } catch (e) {
      return false;
    }
  }
}
