import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';

Future<void> resetGameFirebase(int gridSize) async {
  Map<String, String> game = {};
  for (int i = 0; i < gridSize * gridSize; i++) {
    game[i.toString()] = "";
  }

  await FirebaseFirestore.instance
      .collection("tic-tac-toe")
      .doc(gameId)
      .update({
    "game": game,
  });
}
