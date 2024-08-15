import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData themeData = Hive.box("theme").get("themeData") == "darkMode" ||
          Hive.box("theme").get("themeData") == null
      ? darkMode
      : lightMode;

  ThemeData get getThemeData => themeData;

  set setThemeData(ThemeData setThemeData) {
    themeData = setThemeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
      Hive.box("theme").put("themeData", "darkMode");
      notifyListeners();
    } else {
      themeData = lightMode;
      Hive.box("theme").put("themeData", "lightMode");
      notifyListeners();
    }
  }
}
