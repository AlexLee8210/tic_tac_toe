import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tic_tac_toe/models/piece.dart';
import 'package:tic_tac_toe/widgets/piece_widget.dart';

class Board {
  late List<Widget> p1Pieces; // List of P1 pieces
  late List<Widget> p2Pieces; // List of AI pieces
  late List<Piece?> gbPieces; // List of pieces on the game board

  bool _p1Turn = true;

  // AI Stuff
  var bestIndex = -1;
  Piece? bestPiece;

  Board() {
    gbPieces = List.filled(
      9,
      null,
      growable: false,
    );
  }

  get p1Turn => _p1Turn;

  void nextTurn() => _p1Turn = !_p1Turn;

  void placePiece(int index, Piece p) {
    gbPieces[index] = p;
    _removePiece(p);
  }

  void _removePiece(Piece p) {
    List<Widget> list = p.player == 1 ? p1Pieces : p2Pieces;

    for (int i = list.length - 1; i >= 0; i--) {
      Widget d = list[i];
      if (((d as Draggable).child as PieceWidget).piece == p) {
        list.removeAt(i);
        // p.player == 1 ? p1Pieces = p1Pieces : p2Pieces = p2Pieces;
        return;
      }
    }
  }

  //-1 = no winner yet, 0 = draw, 1 = p1 won, 2 = p2 won
  int checkWinner(int spot) {
    bool draw = true;
    //Check for draw

    if (!gbPieces.contains(null)) {
      for (Piece? gbPiece in gbPieces) {
        for (Widget w in p1Pieces) {
          Piece p = ((w as Draggable).child as PieceWidget).piece;

          //if ((gbPiece as Piece).player == (_p1Turn ? 1 : 2)) continue;
          if (p.type > (gbPiece as Piece).type) {
            draw = false;
            break;
          }
        }
        for (Widget w in p2Pieces) {
          Piece p = ((w as Draggable).child as PieceWidget).piece;

          //if ((gbPiece as Piece).player == (_p1Turn ? 1 : 2)) continue;
          if (p.type > (gbPiece as Piece).type) {
            draw = false;
            break;
          }
        }
      }
    } else if (p1Pieces.isEmpty && p2Pieces.isEmpty) {
      draw = true;
    } else {
      draw = false;
    }

    if (draw) return 0;

    int diag = -1;
    if (spot % 2 == 0) {
      diag = _diagonalCheck(spot);
    }
    return max(diag, max(_horizontalCheck(spot), _verticalCheck(spot)));
  }

  int _horizontalCheck(int spot) {
    int col = spot % 3; //if number % 3 == 0, +1 +2, ==1 -1+1, ==2 -2-1
    int check1 = 1, check2 = 2;
    if (col == 1) {
      check1 = -1;
      check2 = 1;
    } else if (col == 2) {
      check1 = -2;
      check2 = -1;
    }

    //Null Checks
    if (gbPieces[spot + check1] == null) return -1;
    if (gbPieces[spot + check2] == null) return -1;

    int currPlayer = (gbPieces[spot] as Piece).player;
    if (gbPieces[spot + check1]?.player != currPlayer) return -1;
    if (gbPieces[spot + check2]?.player != currPlayer) return -1;
    return currPlayer;
  }

  int _verticalCheck(int spot) {
    int col = spot % 3;

    //Null Checks
    if (gbPieces[col] == null) return -1;
    if (gbPieces[col + 3] == null) return -1;
    if (gbPieces[col + 6] == null) return -1;

    int currPlayer = (gbPieces[spot] as Piece).player;
    if ((gbPieces[col] as Piece).player != currPlayer) return -1;
    if ((gbPieces[col + 3] as Piece).player != currPlayer) return -1;
    if ((gbPieces[col + 6] as Piece).player != currPlayer) return -1;
    return currPlayer;
  }

  int _diagonalCheck(int spot) {
    if (gbPieces[4] == null) return -1;

    int currPlayer = (gbPieces[spot] as Piece).player;
    int diagResult = currPlayer, antiResult = currPlayer;

    if (gbPieces[4]?.player != currPlayer) return -1;

    if (gbPieces[0] == null) {
      diagResult = -1;
    } else if (gbPieces[8] == null) {
      diagResult = -1;
    }

    if (gbPieces[0]?.player != currPlayer) {
      diagResult = -1;
    } else if (gbPieces[8]?.player != currPlayer) {
      diagResult = -1;
    }

    if (gbPieces[2] == null) {
      antiResult = -1;
    } else if (gbPieces[6] == null) {
      antiResult = -1;
    }

    if (gbPieces[2]?.player != currPlayer) {
      antiResult = -1;
    } else if (gbPieces[6]?.player != currPlayer) {
      antiResult = -1;
    }

    return max(diagResult, antiResult);
  }

  void bestMove() {
    var bestScore = double.negativeInfinity;
    bestIndex = -1;

    for (int i = 0; i < gbPieces.length; i++) {
      // If spot is empty
      if (gbPieces[i] == null) {
        for (int j = 0; j < p2Pieces.length; j++) {
          var currPiece =
              ((p2Pieces[j] as Draggable).child as PieceWidget).piece;

          gbPieces[i] = currPiece;
          var score = _minimax(i, currPiece, 0, true);
          gbPieces[i] = null;

          if (score > bestScore) {
            bestScore = score;
            bestIndex = i;
            bestPiece = currPiece;
          }
        }
      }
    }

    placePiece(
        bestIndex,
        bestPiece ??
            const Piece(
              color: Colors.black,
              icon: Icons.abc,
              player: 3,
              type: 4,
            ));
  }

  double _minimax(int index, Piece? piece, double score, bool isMaximizing) {
    int winner = checkWinner(index);
    if (winner > -1) {
      if (winner == 1) return score - 1;
      return score + 1;
    }

    var bestScore = score;
    var bestIndex = index;
    Piece? bestPiece = piece;
    if (isMaximizing) {
      for (int i = 0; i < gbPieces.length; i++) {
        // If spot is empty
        if (gbPieces[i] == null) {
          for (int j = 0; j < p2Pieces.length; j++) {
            Piece currPiece =
                ((p2Pieces[j] as Draggable).child as PieceWidget).piece;
            gbPieces[i] = currPiece;
            var currScore = _minimax(i, gbPieces[i], score, !isMaximizing);
            gbPieces[i] = null;

            if (currScore > bestScore) {
              bestScore = currScore;
              bestIndex = i;
              bestPiece = currPiece;
            }
          }
          return bestScore;
        }
      }
    } else {
      for (int i = 0; i < gbPieces.length; i++) {
        // If spot is empty
        if (gbPieces[i] == null) {
          for (int j = 0; j < p1Pieces.length; j++) {
            Piece currPiece =
                ((p1Pieces[j] as Draggable).child as PieceWidget).piece;
            gbPieces[i] = currPiece;
            var currScore = _minimax(i, gbPieces[i], score, !isMaximizing);
            gbPieces[i] = null;

            if (currScore < bestScore) {
              bestScore = currScore;
              bestIndex = i;
              bestPiece = currPiece;
            }
          }
          return bestScore;
        }
      }
    }

    return _minimax(bestIndex, bestPiece, bestScore, !isMaximizing);
  }
}
