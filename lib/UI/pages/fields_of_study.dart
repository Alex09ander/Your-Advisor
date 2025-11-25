import 'package:flutter/material.dart';

import '../../domain/app_routes.dart';

// --- MOCK DATA MODELS ---
// Clean models ready for your backend integration later.

class Job {
  final String title;
  final String description;
  final IconData icon;

  const Job({
    required this.title,
    required this.description,
    required this.icon,
  });
}

enum FieldCategory { main, supplementary }

class StudyField {
  final String title;
  final String description;
  final FieldCategory category;

  const StudyField({
    required this.title,
    required this.description,
    required this.category,
  });
}

class University {
  final String name;
  final String description;
  final String badgeLabel;

  const University({
    required this.name,
    required this.description,
    required this.badgeLabel,
  });
}

// --- MAIN SCREEN ---

class JobPathwaysScreen extends StatelessWidget {
  const JobPathwaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MOCK DATA INJECTION
    const job = Job(
      title: 'Specjalista ds. cyberbezpieczeństwa',
      description:
          'Odpowiada za ochronę systemów informatycznych przed atakami, monitorowanie zagrożeń oraz wdrażanie polityk bezpieczeństwa w organizacji.',
      icon: Icons.security,
    );

    const university = University(
      name: 'Politechnika Warszawska',
      description:
          'Wydział Elektroniki i Technik Informacyjnych oferuje jedne z najlepszych laboratoriów w kraju.',
      badgeLabel: 'Rekomendacja',
    );

    final fields = [
      const StudyField(
        title: 'Informatyka',
        description:
            'Solidne podstawy programowania, sieci komputerowych i architektury systemów.',
        category: FieldCategory.main,
      ),
      const StudyField(
        title: 'Cyberbezpieczeństwo',
        description:
            'Specjalistyczna wiedza z zakresu kryptografii, pentestingu i analizy malware.',
        category: FieldCategory.main,
      ),
      const StudyField(
        title: 'Matematyka Stosowana',
        description:
            'Kluczowa dla zrozumienia algorytmów szyfrujących i analizy danych.',
        category: FieldCategory.supplementary,
      ),
      const StudyField(
        title: 'Prawo i Administracja',
        description:
            'Przydatne w aspektach regulacji RODO i compliance w bezpieczeństwie.',
        category: FieldCategory.supplementary,
      ),
    ];

    // Grouping fields
    final mainFields =
        fields.where((f) => f.category == FieldCategory.main).toList();
    final suppFields =
        fields.where((f) => f.category == FieldCategory.supplementary).toList();

    return Scaffold(
      // Using a slightly colored background standard in M3
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Job Header Section
            _JobHeader(job: job),
            
            const SizedBox(height: 32),

            // 2. Recommended University (The "Eye Candy")
            _UniversitySpotlight(university: university),

            const SizedBox(height: 32),

            // 3. Main Fields of Study
            _SectionHeader(
              title: 'Główne ścieżki',
              icon: Icons.school,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            ...mainFields.map((field) => _StudyFieldCard(field: field)),

            const SizedBox(height: 24),

            // 4. Supplementary Fields (Alternative)
            // "Kierunki Uzupełniające" sounds professional for "Alternative"
            _SectionHeader(
              title: 'Kierunki uzupełniające',
              icon: Icons.lightbulb_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.only(bottom: 12, left: 4),
              child: Text(
                "Warto rozważyć dla szerszej perspektywy zawodowej.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            ...suppFields.map((field) => _StudyFieldCard(field: field)),
            
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS ---

class _JobHeader extends StatelessWidget {
  final Job job;

  const _JobHeader({required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            job.icon,
            size: 48,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          job.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          job.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _UniversitySpotlight extends StatelessWidget {
  final University university;

  const _UniversitySpotlight({required this.university});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // M3 Expressive: Using Tertiary container for highlights/discovery
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(28), // Expressive large radius
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: theme.colorScheme.onTertiaryContainer),
              const SizedBox(width: 8),
              Text(
                university.badgeLabel.toUpperCase(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            university.name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            university.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryContainer.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.onTertiaryContainer,
              foregroundColor: theme.colorScheme.tertiaryContainer,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Zobacz uczelnię"),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _StudyFieldCard extends StatelessWidget {
  final StudyField field;

  const _StudyFieldCard({required this.field});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMain = field.category == FieldCategory.main;

    return Card(
      // M3 Expressive: Using Surface Container High for cards to separate from bg
      color: isMain 
          ? theme.colorScheme.surfaceContainerHigh 
          : theme.colorScheme.surfaceContainer, 
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isMain 
            ? BorderSide.none 
            : BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      field.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (isMain)
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                field.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                // M3 Tonal Button for lower emphasis actions
                child: isMain 
                  ? FilledButton.tonal(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.study_details_page);
                      },
                      child: const Text('Szczegóły'),
                    )
                  : OutlinedButton(
                      onPressed: () {},
                      child: const Text('Szczegóły'),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- MAIN APP ENTRY POINT FOR PREVIEW ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Pathways',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // M3 Expressive often uses slightly bolder color seeds
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006493), // Deep Tech Blue
          brightness: Brightness.light,
          // Ensuring the tertiary color pops for the University card
          tertiary: const Color(0xFF7D5260), 
        ),
        // Defining default shapes for the app
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const JobPathwaysScreen(),
    );
  }
}