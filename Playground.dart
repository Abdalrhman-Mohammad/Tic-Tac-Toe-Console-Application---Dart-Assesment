import "dart:io";

int NumberOfFilledCells = 0; //Number Of Cells that used
int N = 3;
List<List<String>> Area = []; //The area players playing on
Turn? turn; //turn of player who playing now
String?
    message; //Contain the message will appear for user , to determine the turn for who and give the option for players to end the game
String signs = "XO"; //Signs that players use while playing sorted as the users

void main() {
  turn = Turn.FirstPlayer;
  creatingArea();
  while (true) {
    //Printint area
    printArea();
    //Check if the result of the game is draw
    CheckDrawing(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer);
    //Check if one of the players won
    CheckWinning(
        turn == Turn.FirstPlayer ? Turn.SecondPlayer : Turn.FirstPlayer);
    printingMessagesForMoves();
    //Give the other player the turn to play in the next move
    changeTheTurn();
  }
}

void creatingArea() {
  for (int i = 0; i < N; i++) {
    List<String> row = [];
    for (int j = 1; j <= N; j++) {
      int num = i * N + j;
      row.add("$num");
    }
    Area.add(row);
  }
}

void printArea() {
  //Printing area
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      stdout.write(" " + Area[i][j] + " ");
      if (j < N - 1) stdout.write("|");
    }
    print("");
    if (i < N - 1) print("---+---+---");
  }
}

void changeTheTurn() {
  //If player one playing now , give the next move to player two and vise versa
  if (turn == Turn.FirstPlayer)
    turn = Turn.SecondPlayer;
  else
    turn = Turn.FirstPlayer;
}

void printingMessagesForMoves() {
  //These conditions check who player is playing now to determine the suitable message that will appear
  if (turn == Turn.FirstPlayer)
    message = "Player 1";
  else
    message = "Player 2";
  message = message! +
      ",please enter the number of the square where want to place your ";
  if (turn == Turn.FirstPlayer)
    message = message! + "X:";
  else
    message = message! + "O:";
  message = message! + " (Or 'X' to end the game)";
  print(message);
  // The option that player will choose (choose a square or end the game)
  String option = stdin.readLineSync()!;
  if (option == 'X') {
    print("Game is ENDED!!");
    exit(0);
  }
  //Variable contain the number for square the player chose if didn't choose to end the game
  int num = int.parse(option);
  while (!ValidSign(num, turn)) {
    num = int.parse(stdin.readLineSync()!);
    print(message);
  }
}

bool ValidSign(int num, Turn? turn) {
  int r = ((num - 1) / N).toInt();
  int c = (num - 1) % N;
  if (Area[r][c] == "$num") {
    NumberOfFilledCells++;
    Area[r][c] = turn == Turn.FirstPlayer ? 'X' : 'O';
    return true;
  } else
    return false;
}

void CheckDrawing(Turn turn) {
  if (NumberOfFilledCells == N * N) {
    print("Game ended with draw result!!!");
    exit(0);
  }
}

void printWInner(turn) {
  print("Congrats " +
      (turn == Turn.FirstPlayer ? "Player 1" : "Player 2") +
      " Win!!!");
}

bool checkingRows() {
  //Rows checking
  bool find = false;
  for (int i = 0; i < N; i++) {
    find = true;
    for (int j = 0; j < N; j++) {
      for (int k = j + 1; k < N; k++) {
        if (Area[i][j] != Area[i][k]) {
          find = false;
          break;
        }
      }
      if (!find) {
        break;
      }
    }
    if (find) {
      break;
    }
  }
  return find;
}

bool checkingColumns() {
  //Columns checking
  bool find = false;
  for (int i = 0; i < N; i++) {
    find = true;
    for (int j = 0; j < N; j++) {
      for (int k = j + 1; k < N; k++) {
        if (Area[j][i] != Area[k][i]) {
          find = false;
          break;
        }
      }
      if (!find) {
        break;
      }
    }
    if (find) {
      break;
    }
  }
  return find;
}

bool checkingMainDiagonal() {
  //Main Diagonal checking
  bool ans = true;
  for (int i = 0; i < N && ans; i++) {
    for (int j = i + 1; j < N && ans; j++) {
      if (Area[i][i] != Area[j][j]) {
        ans = false;
        break;
      }
    }
  }
  return ans;
}

bool checkSecondaryDiagonal() {
  //Secondary Diagonal checking
  bool ans = true;
  for (int i = 0; i < N && ans; i++) {
    for (int j = i + 1; j < N && ans; j++) {
      if (Area[i][N - i - 1] != Area[j][N - j - 1]) {
        ans = false;
        break;
      }
    }
  }
  return ans;
}

void CheckWinning(turn) {
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
      exit(0);
    }
  }
}

enum Turn {
  FirstPlayer,
  SecondPlayer,
}

