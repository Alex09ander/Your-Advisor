import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_advisor/UI/theme/theme_controller.dart';

class AccessibilityToggle extends StatelessWidget {
  const AccessibilityToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final scheme = Theme.of(context).colorScheme;

    const icon = Icons.accessibility_new_outlined;

    final tooltip =
        themeController.accessibilityOn ? "Wyłącz tryb dostępności" : "Tryb dostępności";
    return themeController.accessibilityOn
        ? IconButton.filledTonal(
            tooltip: tooltip,
            icon: Icon(icon, color: scheme.onSurface),
            onPressed: () {
              print('juj');
              themeController.toggleAccessibility();
            },
          )
        : IconButton.outlined(
            tooltip: tooltip,
            icon: Icon(icon, color: scheme.onSurface),
            onPressed: () {
              print('juj');
              themeController.toggleAccessibility();
            },
          );
  }
}
