// test_page_psychology.dart

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
  // Constants
  static const int _closedQuestionsCount = 17;
  static const int _openQuestionsCount = 4;
  static const int _totalQuestionsCount = _closedQuestionsCount + _openQuestionsCount;
  static const int _likertScaleOptions = 7;
  static const int _defaultLikertValue = 0; // 0 means not selected

  // Controllers
  final TextEditingController _textController = TextEditingController();

  // Questions
  static const List<String> _closedQuestions = [
    "Najlepiej czuję się, gdy wokół mnie jest dużo ludzi",
    "Na spotkaniach lubię zabierać głos i inicjować rozmowę",
    "Zwykle planuję zadania z wyprzedzeniem i wcześnie zaczynam pracę",
    "Nawet gdy mi się nie chce, potrafię dokończyć rozpoczętą pracę",
    "Często staram się zrozumieć punkt widzenia drugiej osoby, nawet jeśli się nie zgadzam",
    "Jestem bezkompromisowy i często walczę o swoje",
    "W stresujących sytuacjach zwykle zachowuję spokój",
    'Często długo „przeżywam" porażki lub krytykę',
    "Często wpadam na nietypowe pomysły lub rozwiązania",
    "Lubię tworzyć coś własnego (np. muzykę, grafikę, teksty, projekty)",
    "Potrzebuję logicznych argumentów, żeby podjąć jakąś decyzję",
    'Zdarza mi się podejmować ważne decyzje „pod wpływem chwili" lub intuicji',
    "Łatwo się rozpraszam, kiedy pracuję nad jednym zadaniem",
    "Zaczynam rzeczy z entuzjazmem, ale trudno mi je dokończyć",
    "W grupie często przejmuję inicjatywę i organizuję działania",
    "Czuję się komfortowo, kiedy jestem odpowiedzialny za decyzje dotyczące innych ludzi",
    "Inni ludzie często proszą mnie o radę lub pomoc w podjęciu decyzji",
  ];

  static const List<String> _openQuestions = [
    "Czego najbardziej brakuje Ci w obecnym życiu, żebyś czuł/czuła się spełniony/a?",
    "Jaki byłby Twój wymarzony partner życiowy lub idealna relacja z drugą osobą?",
    "Jak wyglądałby Twój idealny dzień – od poranka do wieczora?",
    "Czego w życiu najbardziej się obawiasz i dlaczego?",
  ];

  // State
  final List<int> _closedAnswers =
      List.filled(_closedQuestionsCount, _defaultLikertValue);
  final List<String> _openAnswers = List.filled(_openQuestionsCount, "");
  int _currentQuestionIndex = 0;
  int _selectedLikertValue = _defaultLikertValue;

  List<String> get _allQuestions => [..._closedQuestions, ..._openQuestions];

  bool get _isOpenQuestion => _currentQuestionIndex >= _closedQuestionsCount;
  bool get _isLastQuestion => _currentQuestionIndex == _totalQuestionsCount - 1;
  double get _progressValue => (_currentQuestionIndex / _totalQuestionsCount) * 350;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const Gap(70),
              ProgressBar(progress: _progressValue),
              const Gap(30),
              const Spacer(),
              Text(
                _allQuestions[_currentQuestionIndex],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(30),
              _isOpenQuestion ? _buildOpenInput() : _buildClosedOptions(),
              const Spacer(),
              _buildBottomButtons(),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpenInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: TextField(
          controller: _textController,
          minLines: 5,
          maxLines: 10,
          decoration: const InputDecoration(labelText: "Wprowadź odpowiedź"),
        ),
      ),
    );
  }

  Widget _buildClosedOptions() {
    const labels = [
      "Zdecydowanie się zgadzam",
      "Zgadzam się",
      "Trochę się zgadzam",
      "Nie mam zdania",
      "Trochę się nie zgadzam",
      "Nie zgadzam się",
      "Zdecydowanie się nie zgadzam",
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          for (int i = 0; i < _likertScaleOptions; i++) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(60),
                onTap: () => _handleLikertSelection(i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      CustomCircleBtn(
                        onTap: () => _handleLikertSelection(i + 1),
                        bgColor: i < 3
                            ? AppColors.greenColor
                            : i == 3
                                ? AppColors.greyColor
                                : AppColors.purpleColor,
                        mRadius: 50,
                        isOutlined: _selectedLikertValue != i + 1,
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
          ],
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 160,
            height: 56,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurfaceVariant,
                side: BorderSide(color: colorScheme.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _handleBack,
              child: const Text(
                "Wróć",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 160,
            height: 56,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _handleNext,
              child: Text(
                _isLastQuestion ? "Zakończ" : "Dalej",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLikertSelection(int value) {
    setState(() {
      _selectedLikertValue = _selectedLikertValue == value ? _defaultLikertValue : value;
    });
  }

  Future<void> _handleNext() async {
    if (_isOpenQuestion) {
      if (_textController.text.trim().isEmpty) return;
      _openAnswers[_currentQuestionIndex - _closedQuestionsCount] =
          _textController.text.trim();
      _textController.clear();
    } else {
      if (_selectedLikertValue == _defaultLikertValue) return;
      _closedAnswers[_currentQuestionIndex] = _selectedLikertValue;
      _selectedLikertValue = _defaultLikertValue;
    }

    if (_isLastQuestion) {
      await _submitTest();
      return;
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _handleBack() {
    if (_currentQuestionIndex == 0) {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.start_page);
      return;
    }

    if (_isOpenQuestion) {
      _openAnswers[_currentQuestionIndex - _closedQuestionsCount] = "";
      _textController.clear();
    } else {
      _closedAnswers[_currentQuestionIndex] = _defaultLikertValue;
      _selectedLikertValue = _defaultLikertValue;
    }

    setState(() {
      _currentQuestionIndex--;
    });
  }

  Future<void> _submitTest() async {
    try {
      _showLoadingDialog(); // 👈 bez await

      final success = await _sendData();

      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // zamknij loader

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Wystąpił błąd: nie udało się zapisać Twojego testu."),
          ),
        );
        return;
      }

      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Dziękujemy za wypełnienie testu"),
          content: Text(
            "Po tym jak już znamy Twoją osobowość, możesz rozpocząć rozmowę z naszym Asystentem.",
          ),
        ),
      );

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.menu_page,
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop(); // spróbuj zamknąć loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nie udało się wysłać testu: $e")),
      );
    }
  }

  Future<bool> _sendData() async {
    final client = Supabase.instance.client;
    var user = client.auth.currentUser;

    try {
      if (user == null) {
        final guestAuth = GuestAuthService(client);
        await guestAuth.ensureSignedInAsGuest();
        user = client.auth.currentUser;
      }

      if (user == null) {
        throw Exception("Brak zalogowanego użytkownika (user == null)");
      }
      final fixedClosed = _closedAnswers.map((v) => v == 0 ? 0 : (8 - v)).toList();

      final payload = TestPayload(
        userId: user.id,
        closedAnswers: fixedClosed,
        openAnswers: _openAnswers,
      );

      final response = await submitPsychologyTest(payload);
      debugPrint("Psychology test sent OK: $response");
      return true;
    } catch (e) {
      debugPrint("Error sending psychology test: $e");
      return false;
    }
  }

  Future<void> _showLoadingDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Wysyłanie wyników...",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
