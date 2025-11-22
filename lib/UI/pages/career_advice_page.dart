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
    setState(() {
      _priority = newPriority;
    });
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
              // Text(
              //   'Na bazie Twojego profilu',
              //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
              //         fontWeight: FontWeight.w600,
              //       ),
              // ),
              // const SizedBox(height: 4),
              // Text(
              //   'Zobacz zawód, który może do Ciebie pasować.',
              //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //         color: colors.onSurfaceVariant,
              //       ),
              // ),
              const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            ),
            segments: const [
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.none,
                label: Text('Obojętnie'),
                icon: Icon(Icons.all_inclusive_rounded),
              ),
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.currently,
                label: Text('Teraz'),
                icon: Icon(Icons.bolt_rounded),
              ),
              ButtonSegment<JobDemandPriority>(
                value: JobDemandPriority.in5Years,
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

    // Mockowy obrazek – możesz potem podmienić na realny z backendu:
    const mockImageUrl =
        'https://images.pexels.com/photos/3184465/pexels-photo-3184465.jpeg?auto=compress&cs=tinysrgb&w=800';

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Card(
          elevation: 1,
          color: colors.surfaceContainerHighest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Zdjęcie zawodu
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        mockImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surface.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.work_outline_rounded,
                                size: 16,
                                color: colors.onSurface,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Propozycja zawodu',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: colors.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      advice.bestJob,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Praca Data Analyst wymaga skupienia podczas analizowania setek danych. '
                      'Twoja sumienność idealnie tu pasuje.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colors.onSurfaceVariant,
                            height: 1.4,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              if (widget.onShowJobDetails != null) {
                                widget.onShowJobDetails!(advice);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('TODO: przejście do szczegółów zawodu'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.info_outline_rounded),
                            label: const Text('Sprawdź zawód'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              if (widget.onShowStudies != null) {
                                widget.onShowStudies!(advice);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('TODO: kierunki studiów'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.school_rounded),
                            label: const Text('Kierunki studiów'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: const Text('Wróć'),
                        style: TextButton.styleFrom(
                          foregroundColor: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
