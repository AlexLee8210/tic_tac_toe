import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/models/board.dart';

import 'package:tic_tac_toe/widgets/piece_widget.dart';
import 'package:tic_tac_toe/widgets/board_widget.dart';
import 'package:tic_tac_toe/widgets/game_end_popup.dart';
import 'package:tic_tac_toe/models/piece.dart';

class SinglePlayerPage extends StatefulWidget {
  final Map<int, IconData> playerIcon;
  final Map<int, Color> playerColor;

  const SinglePlayerPage({
    Key? key,
    required this.playerIcon,
    required this.playerColor,
  }) : super(key: key);

  @override
  State<SinglePlayerPage> createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  late List<Widget> gameBoard; // List of DragTargets on the game board
  late List<Widget> p1Pieces; // List of P1 pieces
  late List<Widget> p2Pieces; // List of AI pieces
  late Board board;

  @override
  void initState() {
    super.initState();
    board = Board();

    gameBoard = List.generate(
      9,
      (index) => DragTarget<Piece>(
        onAccept: ((data) => piecePlaced(data, index)),
        builder: (context, _, __) => AnimatedContainer(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: board.gbPieces[index] == null
                ? Colors.transparent
                : board.gbPieces[index]!.color.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: board.gbPieces[index] == null
                    ? Colors.white10
                    : board.gbPieces[index]!.color.withOpacity(0.2),
                // color: Colors.white10,
                blurRadius: 15.0,
                spreadRadius: -5.0,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          ),
          duration: const Duration(milliseconds: 500),
          child: board.gbPieces[index] == null
              ? null
              : PieceWidget(
                  piece: board.gbPieces[index] as Piece,
                ),
        ),
      ),
      growable: false,
    );

    p1Pieces = List.generate(6, (index) {
      var p = PieceWidget(
        piece: Piece(
          type: ((index + 1) / 2.0).round(),
          color: widget.playerColor[1] as Color,
          player: 1,
          icon: widget.playerIcon[1] as IconData,
        ),
      );

      return Draggable<Piece>(
        data: p.piece,
        feedback: PieceWidget(
          piece: Piece(
            type: ((index + 1) / 2.0).round(),
            color: widget.playerColor[1] as Color,
            player: 1,
            size: 13 + ((index + 1) / 2.0).round() * 20.0,
            icon: widget.playerIcon[1] as IconData,
          ),
        ),
        childWhenDragging: PieceWidget(
          piece: Piece(
            type: ((index + 1) / 2.0).round(),
            color: (widget.playerColor[1] as Color).withAlpha(50),
            player: 1,
            icon: widget.playerIcon[1] as IconData,
          ),
        ),
        child: p,
      );
    });

    p2Pieces = List.generate(6, (index) {
      var p = PieceWidget(
        piece: Piece(
          type: ((index + 1) / 2.0).round(),
          color: widget.playerColor[2] as Color,
          icon: widget.playerIcon[2] as IconData,
          player: 2,
        ),
      );

      return Draggable<Piece>(
        data: p.piece,
        feedback: PieceWidget(
          piece: Piece(
            type: ((index + 1) / 2.0).round(),
            color: widget.playerColor[2] as Color,
            player: 2,
            size: 13 + ((index + 1) / 2.0).round() * 20.0,
            icon: widget.playerIcon[2] as IconData,
          ),
        ),
        childWhenDragging: PieceWidget(
          piece: Piece(
            type: ((index + 1) / 2.0).round(),
            color: (widget.playerColor[2] as Color).withAlpha(50),
            player: 2,
            icon: widget.playerIcon[2] as IconData,
          ),
        ),
        child: p,
      );
    });

    board.p1Pieces = p1Pieces;
    board.p2Pieces = p2Pieces;
  }

  void updatePlayerHands() {
    p1Pieces = board.p1Pieces;
    p2Pieces = board.p2Pieces;
  }

  void piecePlaced(Piece data, int index) {
    setState(() {
      //Check for correct turn
      if (board.p1Turn && data.player != 1) return;
      if (!board.p1Turn && data.player != 2) return;

      bool canPlace = false;

      //Place piece correctly
      if (board.gbPieces[index] != null) {
        //If piece already exists at board spot
        if ((board.gbPieces[index] as Piece).type < data.type) {
          canPlace = true;
        } else {
          return;
        }
      } else {
        canPlace = true;
      }

      if (canPlace) {
        board.placePiece(index, data);
        int winner = board.checkWinner(index);
        board.nextTurn();
        if (winner != -1) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return GameEndPopUp(
                winner: winner,
              );
            },
          );
        } else {
          board.bestMove();

          piecePlaced(board.bestPiece as Piece, board.bestIndex);
          updatePlayerHands();

          board.nextTurn();
          winner = board.checkWinner(board.bestIndex);
          if (winner != -1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return GameEndPopUp(
                  winner: winner,
                );
              },
            );
          }
        }
      }
    });
  }

  void placePieceWidget(int index) {
    setState(() {
      //  = DragTarget<Piece>(
      //   onAccept: ((data) => updateGameBoard(data, index)),
      //   builder: (context, _, __) => AnimatedContainer(
      //     margin: const EdgeInsets.all(2),
      //     decoration: BoxDecoration(
      //       color: board.gbPieces[index] == null
      //           ? Colors.transparent
      //           : board.gbPieces[index]!.color.withOpacity(0.2),
      //       boxShadow: [
      //         BoxShadow(
      //           color: board.gbPieces[index] == null
      //               ? Colors.white10
      //               : board.gbPieces[index]!.color.withOpacity(0.2),
      //           // color: Colors.white10,
      //           blurRadius: 15.0,
      //           spreadRadius: -5.0,
      //         )
      //       ],
      //       borderRadius: BorderRadius.circular(10),
      //       border: Border.all(
      //         width: 1,
      //         color: Colors.white,
      //       ),
      //     ),
      //     duration: const Duration(milliseconds: 500),
      //     child: board.gbPieces[index] == null
      //         ? null
      //         : PieceWidget(
      //             piece: board.gbPieces[index] as Piece,
      //           ),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.blue,
          ],
        ),
      ),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(
            flex: 4,
          ),
          Text(
            board.p1Turn ? 'Player 1\'s Turn' : 'Player 2\'s Turn',
            style: GoogleFonts.fredoka(
              textStyle: const TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: p1Pieces,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          BoardWidget(gameBoard: gameBoard),
          const Spacer(
            flex: 1,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.only(left: 15, right: 15),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: p2Pieces,
            ),
          ),
          const Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
