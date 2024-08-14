import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/ui/providers/text_field_provider.dart';
import 'package:tic_tac_toe/ui/providers/theme_provider.dart';
import 'ui/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => ThemeProvider(),
        ),
        ListenableProvider(
          create: (context) => TextFieldProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      home: const SignInScreen(),
    );
  }
}
