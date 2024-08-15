import 'package:cloud_firestore/cloud_firestore.dart';

void uploadWinner(String uploadPath, String winner) async {
  await FirebaseFirestore.instance
      .collection("tic-tac-toe")
      .doc(uploadPath)
      .update({
    "winner": winner,
  });
}
