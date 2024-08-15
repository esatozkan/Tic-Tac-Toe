import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/data/services/upload_game_history_firebase.dart';
import 'package:tic_tac_toe/firebase_options.dart';
import 'package:tic_tac_toe/ui/providers/game_provider.dart';
import 'package:tic_tac_toe/ui/providers/text_field_provider.dart';
import 'package:tic_tac_toe/ui/providers/theme_provider.dart';
import 'package:tic_tac_toe/ui/views/screens/game_screen.dart';
import 'ui/views/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  await Hive.openBox("theme");
  await Hive.openBox("players");
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: (context) => ThemeProvider(),
        ),
        ListenableProvider(
          create: (context) => TextFieldProvider(),
        ),
        ListenableProvider(
          create: (context) => GameProvider(),
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
    Box players = Hive.box("players");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      home: players.isEmpty
          ? const SignInScreen()
          : FutureBuilder(
              future: uploadGameHistoryFirebase(
                  players.get("player1"), players.get("player2"), 3),
              builder: (context, snapshot) {
                return GameScreen(
                    player1: players.get("player1"),
                    player2: players.get("player2"),
                    gridSize: 3);
              }),
    );
  }
}
