import 'package:flutter/material.dart';
import 'package:tic_tac_toe/data/services/reset_game_firebase.dart';
import 'package:tic_tac_toe/data/services/upload_game_move_firebase.dart';
import 'package:tic_tac_toe/ui/views/widgets/game_screen_widgets/winner_show_dialog_widget.dart';

class GameProvider extends ChangeNotifier {
  bool isPlayer1 = true;
  List<String?> gameBoard = [];
  String? winner;

  bool get getIsPlayer1 => isPlayer1;
  List<String?> get getGameBoard => gameBoard;
  String? get getWinner => winner;

  void generateGrid(int gridSize) {
    gameBoard = List.generate(gridSize * gridSize, (context) => null);
  }

  void makeMove(int index, context) {
    if (gameBoard[index] == null && winner == null) {
      gameBoard[index] = isPlayer1 ? "X" : "O";
      uploadGameMoveFirebase(index, gameBoard[index]!);
      isPlayer1 = !isPlayer1;
      checkForWinner(context);
      notifyListeners();
    }
  }

  void checkForWinner(context) async {
    int gridSize = gameBoard.length == 9
        ? 3
        : gameBoard.length == 16
            ? 4
            : 5;

    for (int i = 0; i < gameBoard.length; i += gridSize) {
      bool rowWin = true;
      for (int j = 0; j < gridSize - 1; j++) {
        if (gameBoard[i + j] == null ||
            gameBoard[i + j] != gameBoard[i + j + 1]) {
          rowWin = false;
          break;
        }
      }
      if (rowWin) {
        winner = gameBoard[i];
        notifyListeners();
        winnerShowDialogWidget(context);
        return;
      }
    }

    for (int i = 0; i < gridSize; i++) {
      bool colWin = true;
      for (int j = 0; j < gridSize - 1; j++) {
        if (gameBoard[i + (j * gridSize)] == null ||
            gameBoard[i + (j * gridSize)] !=
                gameBoard[i + ((j + 1) * gridSize)]) {
          colWin = false;
          break;
        }
      }
      if (colWin) {
        winner = gameBoard[i];
        notifyListeners();
        winnerShowDialogWidget(context);
        return;
      }
    }

    bool diag1Win = true;
    for (int i = 0; i < gridSize - 1; i++) {
      if (gameBoard[(i * gridSize) + i] == null ||
          gameBoard[(i * gridSize) + i] !=
              gameBoard[((i + 1) * gridSize) + (i + 1)]) {
        diag1Win = false;
        break;
      }
    }
    if (diag1Win) {
      winner = gameBoard[0];
      notifyListeners();
      winnerShowDialogWidget(context);
      return;
    }

    bool diag2Win = true;
    for (int i = 0; i < gridSize - 1; i++) {
      if (gameBoard[((i + 1) * gridSize) - (i + 1)] == null ||
          gameBoard[((i + 1) * gridSize) - (i + 1)] !=
              gameBoard[((i + 2) * gridSize) - (i + 2)]) {
        diag2Win = false;
        break;
      }
    }
    if (diag2Win) {
      winner = gameBoard[gridSize - 1];
      notifyListeners();
      winnerShowDialogWidget(context);
      return;
    }

    if (!gameBoard.contains(null) && winner == null) {
      winner = "draw";
      await resetGameFirebase(gridSize).then((value) {
        Future.delayed((const Duration(seconds: 1)), () {
          resetGame(gridSize);
          notifyListeners();
        });
      });
    }
  }

  void resetGame(int gridSize) {
    gameBoard = List.generate(gridSize * gridSize, (index) => null);
    isPlayer1 = true;
    winner = null;
  }
}
