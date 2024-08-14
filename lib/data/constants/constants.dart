import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    tertiary: Colors.amber,
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
