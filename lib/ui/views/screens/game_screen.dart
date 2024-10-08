// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/ui/providers/game_provider.dart';

import 'sign_in_screen.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;
  final int gridSize;
  const GameScreen({
    super.key,
    required this.player1,
    required this.player2,
    required this.gridSize,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    Provider.of<GameProvider>(context, listen: false)
        .resetGame(widget.gridSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
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
        title: Consumer<GameProvider>(builder: (context, gameProvider, _) {
          return Text(
            gameProvider.getIsPlayer1 ? widget.player1 : widget.player2,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          );
        }),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.gridSize * widget.gridSize,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridSize,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => gameProvider.makeMove(index, context),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.primary),
                ),
                child: Center(
                  child: Consumer<GameProvider>(
                      builder: (context, gameProvider, _) {
                    return Text(
                      gameProvider.getGameBoard[index] ?? "",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 48),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
