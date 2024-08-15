// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tic_tac_toe/data/services/delete_game_firebase.dart';

class GameHistoryIconWidget extends StatelessWidget {
  final String gameId;
  final String player1;
  final String player2;
  final String winner;
  final int gridSize;
  final Map<String, dynamic> game;
  const GameHistoryIconWidget({
    super.key,
    required this.gameId,
    required this.player1,
    required this.player2,
    required this.winner,
    required this.gridSize,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Emin misiniz",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                    content: Text("Silinen öğeler geri alınamaz",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "İptal",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await deleteGameHistory(gameId);
                        },
                        child: Text(
                          "Sil",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.primary,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        height: gridSize == 5
            ? game.length * 21
            : gridSize == 4
                ? game.length * 32
                : game.length * 55,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: gridSize == 5 ? 20 : 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    player1,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontFamily: "poppins"),
                  ),
                  Text(
                    player2,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontFamily: "poppins"),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridSize * gridSize,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                        child: Text(
                      game[index.toString()] ?? "",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 48),
                    )),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kazanan: ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18),
                ),
                Text(
                  winner,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
