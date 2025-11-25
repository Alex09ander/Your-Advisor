import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/app_routes.dart';



class StudyDetails extends StatelessWidget {
  const StudyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AppRoutes.fields_of_study);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            // 3. Main Fields of Study
            _SectionHeader(
              title: 'Informatyka',
              icon: Icons.school,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 24),

            _University(
              University: "Uniwersytet Warszawski (UW)",
              Description: "Bardzo mocne podstawy teoretyczne (algorytmy, matematyka, logika), ale też dobra praktyka programistyczna; świetne wyniki w olimpiadach i zawodach programistycznych.",
              //link: 'https://www.uw.edu.pl',
            ),
            const SizedBox(height: 24),
            _University(
              University: "Politechnika Warszawska",
              Description: "Kierunek mocno inżynierski – systemy komputerowe, sieci, elektronika, inżynieria oprogramowania, projekty realizowane często z firmami z branży IT.",
              //link: 'https://www.pw.edu.pl',
            ),
            const SizedBox(height: 24),
            _University(
              University: "AGH Akademia Górniczo‑Hutnicza w Krakowie",
              Description: "Szerokie możliwości specjalizacji (AI, data science, systemy rozproszone, grafika, informatyka przemysłowa); duży nacisk na praktykę i współpracę z biznesem.",
              //link: 'https://www.agh.edu.pl',
            ),
            const SizedBox(height: 24),
            _University(
              University: "Politechnika Wrocławska",
              Description: "Praktycznie nastawiona informatyka inżynierska – programowanie, systemy wbudowane, sieci, bezpieczeństwo, projekty zespołowe; silne powiązanie z wrocławskim rynkiem IT.",
              //link: 'https://pwr.edu.pl',
            ),
            const SizedBox(height: 24),
            _University(
              University: "Politechnika Poznańska",
              Description: "Klasyczna informatyka techniczna – programowanie, bazy danych, sieci, inżynieria oprogramowania; dobra infrastruktura labowa i współpraca z lokalnymi firmami IT.",
              //link: 'https://www.put.poznan.pl',
            ),

            const SizedBox(height: 48), // Bottom padding
          ],
        ),
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
        Icon(icon, color: color, size: 60),
        const SizedBox(width: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}

class _University extends StatelessWidget {
  final String University;
  final String Description;
  final int maxLines;
  final int click;

  const _University({
    required this.University,
    required this.Description,
    this.maxLines = 2,
    this.click = 0,
  });

@override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHigh,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          if(click==0){
            maxLines: 10;
            click: 1;
          } else {
            maxLines: 2;
            click: 0;
          }

        },
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
                      University,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                Description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}





