import 'dart:io';

bool checkWinner(List<List<String>> board, String player) {
  // Check rows
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == player &&
        board[i][1] == player &&
        board[i][2] == player) {
      return true;
    }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    if (board[0][i] == player &&
        board[1][i] == player &&
        board[2][i] == player) {
      return true;
    }
  }

  // Check diagonals
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
    return true;
  }
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
    return true;
  }

  return false;
}

void main() {
  while (true) {
    playGame();

    print("Do you want to play again? (y/n): ");
    String? choice = stdin.readLineSync();
    if (choice == null || choice.toLowerCase() != 'y') {
      print("Thanks for playing!");
      break;
    }
  }
}

void playGame() {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));
  String currentPlayer = 'X';

  while (true) {
    printBoard(board);

    print("Player $currentPlayer, enter your move (1-9): ");
    int move = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    if (move < 1 || move > 9) {
      print("Invalid input! Please enter a number between 1 and 9.");
      continue;
    }

    int row = (move - 1) ~/ 3;
    int col = (move - 1) % 3;

    if (board[row][col] != ' ') {
      print("Cell already occupied! Choose a different move.");
      continue;
    }

    board[row][col] = currentPlayer;

    if (checkWinner(board, currentPlayer)) {
      printBoard(board);
      print("Player $currentPlayer wins!");
      break;
    }

    if (isDraw(board)) {
      printBoard(board);
      print("It's a draw!");
      break;
    }

    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

bool isDraw(List<List<String>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == ' ') return false;
    }
  }
  return true;
}

void printBoard(List<List<String>> board) {
  for (int i = 0; i < 3; i++) {
    print(' ${board[i][0]} | ${board[i][1]} | ${board[i][2]} ');
    if (i < 2) print('---|---|---');
  }
}
