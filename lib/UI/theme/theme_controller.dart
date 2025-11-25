import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool accessibilityOn = false;

  void toggleAccessibility() {
    accessibilityOn = !accessibilityOn;
    notifyListeners();
  }
}
