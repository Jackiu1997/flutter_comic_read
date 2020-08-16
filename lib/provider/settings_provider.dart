import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkMode = false;

  bool get value => _darkMode;
  
  void turnDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}