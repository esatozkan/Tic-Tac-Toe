import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteGameHistory(String deletePath) async {
  await FirebaseFirestore.instance
      .collection("tic-tac-toe")
      .doc(deletePath)
      .delete();
}
