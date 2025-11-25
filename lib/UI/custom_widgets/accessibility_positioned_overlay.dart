import 'package:flutter/material.dart';
import 'package:your_advisor/UI/custom_widgets/accessibility_toggle.dart';

class AccessibilityOverlay extends StatelessWidget {
  const AccessibilityOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 16 + MediaQuery.of(context).padding.top,
      child: const AccessibilityToggle(),
    );
  }
}
