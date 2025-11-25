// test_page_vocational.dart

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
  // Constants
  static const int _closedQuestionsCount = 23;
  static const int _openQuestionsCount = 4;
  static const int _totalQuestionsCount = _closedQuestionsCount + _openQuestionsCount;
  static const int _likertScaleOptions = 7;
  static const int _defaultLikertValue = 0; // 0 means not selected
  static const Duration _sendingAnimationDuration = Duration(milliseconds: 450);
  static const Duration _postSubmitDelay = Duration(milliseconds: 300);

  // Controllers
  final TextEditingController _textController = TextEditingController();

  // Questions
  static const List<String> _closedQuestions = [
    "Dobrze odnajduję się w pracy grupowej",
    "Efektywniej pracuję, jeśli jestem sam",
    "Lubię wykonywać drobne naprawy w domu, albo inną pracę manualną",
    "Jestem sprawny fizycznie i nie przeszkadza mi intensywna praca w ruchu",
    "Wolę pracę na świeżym powietrzu, w otoczeniu natury, niż siedzenie przy biurku",
    "Lubię pisać dłuższe teksty (np. rozprawki, artykuły, opowiadania, blogi)",
    "Lubię wyrażać swoją opinię na dany temat, także publicznie lub na piśmie",
    "Mam wyczucie estetyki i zwracam uwagę na wygląd rzeczy",
    "Regularnie obcuję ze sztuką lub tworzę coś kreatywnego (muzyka, grafika, wideo, rysunek itd.)",
    "Jestem zaawansowany w obsłudze komputera (pakiety biurowe, różne programy, skróty klawiszowe)",
    "Umiem myśleć algorytmicznie – rozbijam problemy na małe kroki i układam z nich procedurę",
    "Lubię pisać kod lub tworzyć własne programy/skrypty, nawet proste",
    "Często samodzielnie szukam w internecie rozwiązań problemów technicznych/programistycznych i sprawia mi to frajdę",
    "Dobrze wyciągam wnioski na podstawie danych, liczb lub statystyk",
    "Poszukuję pracy która zapewni mi stabilność finansową i bezpieczeństwo",
    "Bardzo cenię sobie aspekt finansowy pracy",
    "Chcę, by praca rozwijała mnie jako człowieka, nawet kosztem mniejszych zarobków lub mniejszej stabilności",
    "Wolę pracować zdalnie, z dowolnego miejsca na świecie",
    "Jestem kiepski w wystąpieniach publicznych i unikam ich, jeśli tylko mogę",
    "Szybko uczę się języków obcych i sprawia mi to przyjemność",
    "Łatwo zapamiętuję szczegółowe informacje, kiedy dotyczą zdrowia lub funkcjonowania organizmu",
    "Dobrze radzę sobie w sytuacjach związanych z chorobą, bólem lub stresem innych osób",
    "Lubię brać udział w zorganizowanych projektach grupowych (w szkole, na uczelni, w pracy)",
  ];

  static const List<String> _openQuestions = [
    "Opisz sytuację z pracy, która dała Ci największą satysfakcję i dlaczego?",
    "Jakie umiejętności lub wiedzę chciałbyś/chciałabyś najbardziej rozwijać w swojej karierze?",
    "Czego najbardziej unikasz lub czego się obawiasz w kontekście pracy zawodowej?",
    "Jak praca ma wpływać na Twoje życie prywatne?",
  ];

  // State
  final List<int> _closedAnswers =
      List.filled(_closedQuestionsCount, _defaultLikertValue);
  final List<String> _openAnswers = List.filled(_openQuestionsCount, "");
  int _currentQuestionIndex = 0;
  int _selectedLikertValue = _defaultLikertValue;
  bool _isSending = false;

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
    if (_isSending) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: _buildSendingState(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            ProgressBar(progress: _progressValue),
            const Gap(30),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _allQuestions[_currentQuestionIndex],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Gap(30),
            _isOpenQuestion ? _buildOpenInput() : _buildClosedOptions(),
            const Spacer(),
            _buildBottomButtons(),
            const Gap(40),
          ],
        ),
      ),
    );
  }

  Widget _buildSendingState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: TweenAnimationBuilder<double>(
        duration: _sendingAnimationDuration,
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
          color: colorScheme.surfaceContainerHigh,
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
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'Przetwarzam odpowiedzi…',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Tworzę dla Ciebie profil zawodowy. Zajmie to kilka sekund.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOpenInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
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
      padding: const EdgeInsets.only(left: 20),
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

  void _handleNext() {
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
      _submitTest();
      return;
    }

    setState(() {
      _currentQuestionIndex++;
    });
  }

  Future<void> _submitTest() async {
    setState(() => _isSending = true);

    final success = await _sendData();

    if (!mounted) return;

    if (!success) {
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nie udało się zapisać testu.")),
      );
      return;
    }

    await Future.delayed(_postSubmitDelay);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.career_advice);
  }

  void _handleBack() {
    if (_currentQuestionIndex == 0) {
      Navigator.pushNamed(context, AppRoutes.menu_page);
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

  Future<bool> _sendData() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;

    if (user == null) {
      debugPrint("Error: No authenticated user");
      return false;
    }

    try {
      final payload = TestPayload(
        userId: user.id,
        closedAnswers: _closedAnswers,
        openAnswers: _openAnswers,
      );

      final response = await submitVocationalTest(payload);
      debugPrint("Vocational test sent OK: $response");
      return true;
    } catch (e) {
      debugPrint("Error sending vocational test: $e");
      return false;
    }
  }
}
