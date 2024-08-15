import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';
import 'package:tic_tac_toe/ui/views/screens/sign_in_screen.dart';
import 'package:tic_tac_toe/ui/views/widgets/game_history_widgets/game_history_icon_widget.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: GestureDetector(
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
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
            size: 35,
          ),
        ),
        title: Text(
          "Game History",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: PaginateFirestore(
        query: FirebaseFirestore.instance
            .collection("tic-tac-toe")
            .orderBy("timestamp", descending: true),
        scrollDirection: Axis.vertical,
        itemBuilderType: PaginateBuilderType.listView,
        itemsPerPage: 8,
        isLive: true,
        onEmpty: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Oyun Geçmişi Bulunmamaktadır",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
            ],
          ),
        ),
        onError: (e) {
          return Center(
            child: Text(
              "Bir Hata Oluştu",
              style: TextStyle(color: wrongColor),
            ),
          );
        },
        bottomLoader: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        initialLoader: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        itemBuilder: (context, snapshot, index) {
          final Map<String, dynamic> data =
              snapshot[index].data() as Map<String, dynamic>;
          return GameHistoryIconWidget(
              gameId: data["game-id"],
              player1: data["player1"],
              player2: data["player2"],
              winner: data["winner"] ,
              gridSize: data["grid"],
              game: data["game"]);
        },
      )),
    );
  }
}
