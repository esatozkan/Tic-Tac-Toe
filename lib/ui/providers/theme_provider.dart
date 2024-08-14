import 'package:flutter/material.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData = darkMode;

  ThemeData get getThemeData => themeData;

  set setThemeData(ThemeData setThemeData) {
    themeData = setThemeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
      notifyListeners();
    } else {
      themeData = lightMode;
      notifyListeners();
    }
  }
}
