import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> board;
  late bool player1Turn;
  int playerXWins = 0;
  int playerOWins = 0;
  bool isOneVsOne = true; // true for one-vs-one, false for one-vs-computer

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(3, (i) => List.filled(3, ''));
    player1Turn = true;
  }

  void resetBoard() {
    setState(() {
      initializeBoard();
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = player1Turn ? 'X' : 'O';
        player1Turn = !player1Turn;
      });
      if (checkWinner()) {
        showWinnerDialog();
      } else if (board.every((row) => row.every((cell) => cell != ''))) {
        showDrawDialog();
      } else if (!player1Turn && !isOneVsOne) {
        // If it's the computer's turn in one-vs-computer mode
        makeComputerMove();
      }
    }
  }

  bool checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        updateWins(board[i][0]);
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != '' &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        updateWins(board[0][i]);
        return true;
      }
    }

    // Check diagonals
    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      updateWins(board[0][0]);
      return true;
    }
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      updateWins(board[0][2]);
      return true;
    }

    return false;
  }

  void updateWins(String winner) {
    if (winner == 'X') {
      playerXWins++;
    } else {
      playerOWins++;
    }
  }

  void showWinnerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Winner!',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          content: Text(player1Turn ? 'Player O wins!' : 'Player X wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetBoard();
              },
              child:Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Play Again!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Draw!',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: Text(
            'The game is a draw.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetBoard();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Play Again!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void makeComputerMove() {
    // Simulate a delay to make the computer move look more natural
    Future.delayed(const Duration(seconds: 1), () {
      // Find the best move using the minimax algorithm
      var bestMove = getBestMove();
      if (bestMove != null) {
        makeMove(bestMove[0], bestMove[1]);
      }
    });
  }

  List<int> getBestMove() {
    int bestScore = -1000;
    List<int> bestMove = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '') {
          board[i][j] = 'O';
          int score = minimax(board, 0, false);
          board[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }

    return bestMove;
  }

  int minimax(List<List<String>> currentBoard, int depth, bool isMaximizing) {
    if (checkWinner()) {
      return isMaximizing ? -1 : 1;
    } else if (currentBoard.every((row) => row.every((cell) => cell != ''))) {
      return 0;
    }

    int bestScore = isMaximizing ? -1000 : 1000;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (currentBoard[i][j] == '') {
          currentBoard[i][j] = isMaximizing ? 'O' : 'X';
          int score = minimax(currentBoard, depth + 1, !isMaximizing);
          currentBoard[i][j] = '';
          bestScore =
              isMaximizing ? max(score, bestScore) : min(score, bestScore);
        }
      }
    }

    return bestScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Tic Tac Toe'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: true,
                child: Text('One vs One'),
              ),
              PopupMenuItem(
                value: false,
                child: Text('One vs Computer'),
              ),
            ],
            onSelected: (value) {
              setState(() {
                isOneVsOne = value;
                resetBoard();
              });
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(91, 155, 39, 176),
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(
        //           'images/board.jpg',
        //         ),
        //         fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isOneVsOne)
              Container(
                child: Column(
                  children: [
                    Text('LEADERBOARD',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    Text(
                        'Player X Wins: $playerXWins\nPlayer O Wins: $playerOWins',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => makeMove(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(134, 155, 39, 176),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          board[row][col],
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
