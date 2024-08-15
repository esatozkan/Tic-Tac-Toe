import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';

Future<void> uploadGameHistoryFirebase(
    String player1, String player2, int gridSize) async {
  gameId = DateTime.now().toString().substring(0, 19);

  Map<String, String> game = {};
  for (int i = 0; i < gridSize * gridSize; i++) {
    game[i.toString()] = "";
  }

  await FirebaseFirestore.instance.collection("tic-tac-toe").doc(gameId).set({
    "game-id": gameId,
    "player1": player1,
    "player2": player2,
    "grid": gridSize,
    "timestamp": FieldValue.serverTimestamp(),
    "game": game,
    "winner": "",
  });
}
