import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade200,
    primary: Colors.black,
    secondary: Colors.grey.shade400,
    tertiary: const Color(0xff141414),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xff141414),
    primary: Colors.white,
    secondary: Color.fromARGB(255, 127, 127, 127),
    tertiary: Colors.amber,
  ),
);

Color wrongColor = Colors.red;

String gameId = "";
