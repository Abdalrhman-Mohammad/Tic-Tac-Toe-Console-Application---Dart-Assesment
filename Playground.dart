import "dart:io";

int NumberOfFillCells = 0;
List<List<String>> Area = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9']
];
void main() {
  Turn turn = Turn.FirstPlayer;
  String signs = "XO";
  while (true) {
    for (int i = 0; i < Area.length; i++) {
      for (int j = 0; j < Area[i].length; j++) {
        stdout.write(" " + Area[i][j] + " ");
        if (j < 2) stdout.write("|");
      }
      print("");
      if (i < 2) print("---+---+---");
    }
    if (CheckDrawing(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer)) {
      break;
    }
    if (CheckWinning(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer)) {
      break;
    }
    String message;
    if (turn == Turn.FirstPlayer)
      message =
          "Player 1,please enter the number of the square where want to place your X: (Or 'X' to end the game)";
    else
      message =
          "Player 2,please enter the number of the square where want to place your O: (Or 'X' to end the game)";
    print(message);
    String option = stdin.readLineSync()!;
    if (option == 'X') {
      print("Game is ENDED!!");
      break;
    }
    int num = int.parse(option);
    while (!ValidSign(num, turn)) {
      num = int.parse(stdin.readLineSync()!);
      print(message);
    }
    if (turn == Turn.FirstPlayer)
      turn = Turn.SecondPlayer;
    else
      turn = Turn.FirstPlayer;
  }
}

bool ValidSign(int num, Turn turn) {
  int r = ((num - 1) / 3).toInt();
  int c = (num - 1) % 3;
  if (Area[r][c] == "$num") {
    NumberOfFillCells++;
    Area[r][c] = turn == Turn.FirstPlayer ? 'X' : 'O';
    return true;
  } else
    return false;
}

bool CheckDrawing(Turn turn) {
  if (NumberOfFillCells == 9) {
    print("Game ended with draw result!!!");
    return true;
  }
  return false;
}

void printWInner(turn) {
  print("Congrats " +
      (turn == Turn.FirstPlayer ? "Player 1" : "Player 2") +
      " Win!!!");
}

bool CheckWinning(Turn turn) {
  bool end = false;
  for (int i = 0; i < 3 && !end; i++) {
    if (Area[i][0] == Area[i][1] &&
        Area[i][0] == Area[i][2] &&
        Area[i][1] == Area[i][2]) {
      end = true;
    }
  }
  if (end) {
    printWInner(turn);
    return true;
  }
  for (int i = 0; i < 3 && !end; i++) {
    if (Area[0][i] == Area[1][i] &&
        Area[0][i] == Area[2][i] &&
        Area[1][i] == Area[2][i]) {
      end = true;
    }
  }
  if (end) {
    printWInner(turn);
    return true;
  }
  if (Area[0][0] == Area[1][1] &&
      Area[1][1] == Area[2][2] &&
      Area[0][0] == Area[2][2]) {
    end = true;
  }
  if (end) {
    printWInner(turn);
    return true;
  }
  if (Area[0][2] == Area[1][1] &&
      Area[1][1] == Area[2][0] &&
      Area[0][2] == Area[2][0]) {
    end = true;
  }
  if (end) {
    printWInner(turn);
    return true;
  }
  return false;
}

enum Turn {
  FirstPlayer,
  SecondPlayer,
}
