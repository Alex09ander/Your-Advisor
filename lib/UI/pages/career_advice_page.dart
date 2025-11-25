import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_advisor/domain/career_advice/career_advice_api.dart';

class CareerAdvicePage extends StatefulWidget {
  const CareerAdvicePage({
    super.key,
    required this.userId,
    this.onShowJobDetails,
    this.onShowStudies,
  });

  final String userId;

  /// Callbacki – możesz podpiąć nawigację do szczegółów zawodu / studiów.
  final void Function(CareerAdvice advice)? onShowJobDetails;
  final void Function(CareerAdvice advice)? onShowStudies;

  @override
  State<CareerAdvicePage> createState() => _CareerAdvicePageState();
}

class _CareerAdvicePageState extends State<CareerAdvicePage> {
  JobDemandPriority _priority = JobDemandPriority.none;
  Future<CareerAdvice>? _future;

  @override
  void initState() {
    super.initState();
    _loadAdvice();
  }

  void _loadAdvice() {
    setState(() {
      final api = context.read<CareerAdviceApi>();
      _future = api.getAdvice(widget.userId, _priority);
    });
  }

  void _onPriorityChanged(JobDemandPriority newPriority) {
    if (newPriority == _priority) return;
    setState(() => _priority = newPriority);
    _loadAdvice();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: const Text('Doradca zawodowy'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              _buildPrioritySelector(context),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<CareerAdvice>(
                  future: _future,
                  builder: (context, snapshot) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: () {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return _buildLoadingCard(context);
                        }
                        if (snapshot.hasError) {
                          return _buildErrorState(context, snapshot.error);
                        }
                        if (!snapshot.hasData) {
                          return _buildEmptyState(context);
                        }
                        return _buildAdviceCard(context, snapshot.data!);
                      }(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ====== Priorytet zapotrzebowania na rynku ======

  Widget _buildPrioritySelector(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zapotrzebowanie na rynku',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<JobDemandPriority>(
            style: const ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
            segments: const [
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.none,
                label: Text('Obojętnie'),
                icon: Icon(Icons.all_inclusive_rounded),
              ),
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.current,
                label: Text('Teraz'),
                icon: Icon(Icons.bolt_rounded),
              ),
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.in5years,
                label: Text('Za 5 lat'),
                icon: Icon(Icons.trending_up_rounded),
              ),
            ],
            selected: <JobDemandPriority>{_priority},
            onSelectionChanged: (newSelection) {
              if (newSelection.isEmpty) return;
              _onPriorityChanged(newSelection.first);
            },
            showSelectedIcon: false,
          ),
        ],
      ),
    );
  }

  String _priorityHint(JobDemandPriority p) => switch (p) {
        JobDemandPriority.none => 'bez filtra popytu',
        JobDemandPriority.current => 'z popytem na teraz',
        JobDemandPriority.in5years => 'z popytem za 5 lat',
      };

  /// ====== Stany Future ======

  Widget _buildLoadingCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: colors.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(colors.primary),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  'Dobieram propozycję zawodową dla Ciebie…',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurface,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object? error) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Card(
        elevation: 0,
        color: colors.errorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded, color: colors.onErrorContainer),
              const SizedBox(height: 8),
              Text(
                'Nie udało się pobrać propozycji.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onErrorContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Spróbuj ponownie za chwilę.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onErrorContainer.withOpacity(0.9),
                    ),
              ),
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: _loadAdvice,
                child: const Text('Spróbuj ponownie'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'Brak danych o zawodzie.\nSpróbuj zmienić ustawienia.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
      ),
    );
  }

  /// ====== Karta z zawodem ======

  Widget _buildAdviceCard(BuildContext context, CareerAdvice advice) {
    final colors = Theme.of(context).colorScheme;

    final width = MediaQuery.of(context).size.width;
    final isWide = width > 800;

    const mockImageUrl =
        'https://images.pexels.com/photos/3184465/pexels-photo-3184465.jpeg?auto=compress&cs=tinysrgb&w=800';

    final bool demandFiltered = _priority != JobDemandPriority.none;
    final bool hasDemandMatch = advice.jobWithDemand != null;
    final String bestJob = advice.absoluteBestJob;
    final String mainJob =
        (demandFiltered && hasDemandMatch) ? advice.jobWithDemand! : bestJob;

    return Align(
      alignment: Alignment.topCenter,
      child: isWide
          ? Card(
              elevation: 1,
              color: colors.surfaceContainerHighest,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(28),
                      ),
                      child: AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Image.network(mockImageUrl, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      child: _buildAdviceContent(context, advice, mainJob),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Card(
                elevation: 1,
                color: colors.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(mockImageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                      child: _buildAdviceContent(context, advice, mainJob),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildJobTile(
    BuildContext context,
    ({String job, double score}) item,
    String highlight,
    bool demandActive,
    Set<String> fits,
    double maxScore,
  ) {
    final colors = Theme.of(context).colorScheme;

    final raw = item.score;
    num transform(num number) => math.pow(number, 1 / 4);
    final norm = transform(raw);
    final maxNorm = transform(maxScore);
    final value = (norm / maxNorm).clamp(0.0, 1.0);

    final isMain = item.job == highlight;
    final demandOK = fits.contains(item.job);

    // tło
    final bg = demandActive
        ? (demandOK
            ? colors.primaryContainer.withOpacity(0.55)
            : colors.surfaceContainerLow.withOpacity(0.30))
        : (isMain
            ? colors.primaryContainer.withOpacity(0.6)
            : colors.surfaceContainerLow);

    // ramka
    final borderColor = demandActive
        ? (demandOK ? colors.primary : Colors.transparent)
        : (isMain ? colors.primary : colors.outlineVariant);

    // tekst
    final textColor =
        demandActive && !demandOK ? colors.onSurface.withOpacity(0.35) : colors.onSurface;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.job,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: isMain ? FontWeight.w700 : FontWeight.w600,
                        color: textColor,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(value * 100).round()}%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: colors.surfaceContainerHigh,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceContent(BuildContext context, CareerAdvice advice, String mainJob) {
    final colors = Theme.of(context).colorScheme;
    final demandFiltered = _priority != JobDemandPriority.none;
    final hasDemandMatch = advice.jobWithDemand != null;
    final bestJob = advice.absoluteBestJob;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainJob,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),
        if (demandFiltered && !hasDemandMatch)
          _buildNoDemandMatchBanner(context, _priority, bestJob)
        else
          Text(
            'To najwyżej oceniana opcja na bazie Twojej osobowości.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
          ),
        const SizedBox(height: 12),
        _buildTopJobsList(context, advice, highlight: mainJob),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              if (widget.onShowStudies != null) {
                widget.onShowStudies!(advice);
              }
            },
            icon: const Icon(Icons.info_outline_rounded),
            label: const Text('Sprawdź zawód'),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Wróć'),
          ),
        ),
      ],
    );
  }

  Widget _buildNoDemandMatchBanner(
      BuildContext context, JobDemandPriority demandPriority, String bestJob) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.search_off_rounded, color: colors.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demandPriority == JobDemandPriority.current
                      ? 'Nie znalezłem dla Ciebie zawodu z popytem na teraz.'
                      : 'Nie znalazłem dla Ciebie zawodu z popytem za 5 lat',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bez względu na popyt, warto rozważyć: $bestJob.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.35,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopJobsList(
    BuildContext context,
    CareerAdvice advice, {
    required String highlight,
  }) {
    final colors = Theme.of(context).colorScheme;

    final width = MediaQuery.of(context).size.width;
    final isWide = width > 800;

    final pairs = <({String job, double score})>[];
    for (var i = 0; i < math.min(advice.jobs.length, advice.scores.length); i++) {
      pairs.add((job: advice.jobs[i], score: advice.scores[i]));
    }
    pairs.sort((a, b) => b.score.compareTo(a.score));

    final maxScore = pairs.isEmpty
        ? 1.0
        : pairs.map((e) => e.score).reduce(math.max).clamp(1e-9, double.infinity);

    final top = pairs.take(5).toList();

    if (top.isEmpty) return const SizedBox.shrink();

    final demandActive = _priority != JobDemandPriority.none;
    final fits = advice.fitsToDemand;

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 6,
        ),
        itemCount: top.length,
        itemBuilder: (context, index) {
          final item = top[index];
          return _buildJobTile(
              context, item, highlight, demandActive, fits.toSet(), maxScore);
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Top propozycje',
        //   style: Theme.of(context).textTheme.titleSmall?.copyWith(
        //         fontWeight: FontWeight.w700,
        //         color: colors.onSurface,
        //       ),
        // ),
        // const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: top.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = top[index];
            final raw = item.score;
            num transform(num number) => math.pow(number, 1 / 4);
            final norm = transform(raw);
            final maxNorm = transform(maxScore);
            final value = (norm / maxNorm).clamp(0.0, 1.0);
            final isMain = item.job == highlight;

            final demandOK = fits.contains(item.job);

// kolor tła
            final bg = demandActive
                ? (demandOK
                    ? colors.primaryContainer.withOpacity(0.55)
                    : colors.surfaceContainerLow.withOpacity(0.30))
                : (isMain
                    ? colors.primaryContainer.withOpacity(0.6)
                    : colors.surfaceContainerLow);

// border
            final borderColor = demandActive
                ? (demandOK ? colors.primary : Colors.transparent)
                : (isMain ? colors.primary : colors.outlineVariant);

// tekst
            final textColor = demandActive && !demandOK
                ? colors.onSurface.withOpacity(0.35)
                : colors.onSurface;

            return Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.job,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: isMain ? FontWeight.w700 : FontWeight.w600,
                                color: textColor,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(value * 100).round()}%',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 7,
                      backgroundColor: colors.surfaceContainerHigh,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
