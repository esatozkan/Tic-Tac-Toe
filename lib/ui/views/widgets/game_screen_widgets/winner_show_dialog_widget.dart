import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/ui/providers/game_provider.dart';
import 'package:tic_tac_toe/ui/views/screens/game_history_screen.dart';

import '../../../../data/constants/constants.dart';
import '../../../../data/services/upload_winner_firebase.dart';
import '../../screens/sign_in_screen.dart';

Future<dynamic> winnerShowDialogWidget(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  GameProvider gameProvider = Provider.of<GameProvider>(context, listen: false);
  uploadWinner(gameId, gameProvider.getWinner!);
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(
      child: Container(
        width: width * 0.8,
        height: height * 0.4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              width: width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Kazanan",
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "poppins"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height / 13),
              child: Text(
                gameProvider.getWinner!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 30,
                    fontFamily: "poppins"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Box playerBox = Hive.box("players");
                    playerBox.put("player1", "");
                    playerBox.put("player2", "");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: width / 3,
                    height: height / 20,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Çıkış",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontFamily: "poppins"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameHistoryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: width / 3,
                    height: height / 20,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Oyun Geçmişi",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontFamily: "poppins"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
