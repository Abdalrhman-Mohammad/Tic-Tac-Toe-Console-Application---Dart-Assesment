import "dart:io";

int NumberOfFillCells = 0; //Number Of Cells that used

List<List<String>> Area = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9']
]; //The area player playing on
void main() {
  Turn turn = Turn.FirstPlayer; //turn of player playing now
  String signs =
      "XO"; //Signs that players used while playing sorted as the users
  while (true) {
    for (int i = 0; i < Area.length; i++) {
      for (int j = 0; j < Area[i].length; j++) {
        stdout.write(" " + Area[i][j] + " ");
        if (j < 2) stdout.write("|");
      }
      print("");
      if (i < 2) print("---+---+---");
    } //Printing the area
    //Check if the result of the game is draw
    if (CheckDrawing(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer)) {
      break;
    }
    //Check if one of the players won
    if (CheckWinning(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer)) {
      break;
    }

    String
        message; //Contain the meesage will appear for user to determine the turn for who and give the option for players to end the game
    //These conditions check who player is playing now to determine the sutable message that will appear
    if (turn == Turn.FirstPlayer)
      message =
          "Player 1,please enter the number of the square where want to place your X:";
    else
      message =
          "Player 2,please enter the number of the square where want to place your O:";
    message = message + " (Or 'X' to end the game)";
    print(message); //
    String option = stdin
        .readLineSync()!; // The option that player will choose (choose a square or end the game)
    if (option == 'X') {
      print("Game is ENDED!!");
      break;
    }
    int num = int.parse(
        option); //Variable contain the number of square the player chose if didn't choose to end the game
    while (!ValidSign(num, turn)) {
      num = int.parse(stdin.readLineSync()!);
      print(message);
    }
    //Give the other player the turn to play in the next move
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

bool checkingRows() {
  //Rows checking
  for (int i = 0; i < 3; i++) {
    if (Area[i][0] == Area[i][1] &&
        Area[i][0] == Area[i][2] &&
        Area[i][1] == Area[i][2]) {
      return true;
    }
  }
  return false;
}

bool checkingColumns() {
  //Columns checking
  for (int i = 0; i < 3; i++) {
    if (Area[0][i] == Area[1][i] &&
        Area[0][i] == Area[2][i] &&
        Area[1][i] == Area[2][i]) {
      return true;
    }
  }
  return false;
}

bool checkingMainDiagonal() {
  //Main Diagonal checking
  if (Area[0][0] == Area[1][1] &&
      Area[1][1] == Area[2][2] &&
      Area[0][0] == Area[2][2]) {
    return true;
  }
  return false;
}

bool checkSecondaryDiagonal() {
  //Secondary Diagonal checking
  if (Area[0][2] == Area[1][1] &&
      Area[1][1] == Area[2][0] &&
      Area[0][2] == Area[2][0]) {
    return true;
  }
  return false;
}

bool CheckWinning(turn) {
  List<Function> checks = [
    checkingRows,
    checkingColumns,
    checkingMainDiagonal,
    checkSecondaryDiagonal
  ];
  bool tmp;
  for (Function f in checks) {
    tmp = f();
    if (tmp) {
      printWInner(turn);
      return true;
    }
  }
  return false;
}

enum Turn {
  FirstPlayer,
  SecondPlayer,
}

