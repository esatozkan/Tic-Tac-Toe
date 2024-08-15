import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';

void uploadGameMoveFirebase(int index, String move) async {
  FirebaseFirestore.instance.collection("tic-tac-toe").doc(gameId).update({
    "game.$index": move,
  });
}
