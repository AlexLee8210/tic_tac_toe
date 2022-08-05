import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tic_tac_toe/models/piece.dart';

class PieceWidget extends StatelessWidget {
  final Piece piece;

  const PieceWidget({
    Key? key,
    required this.piece,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: piece.color.withAlpha(100),
            spreadRadius: 1,
            blurRadius: 25.0,
          )
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Icon(
            piece.icon,
            color: piece.color,
            size: piece.size ?? 10 + piece.type * 20.0,
          ),
          // Icon(
          //   Icons.circle,
          //   color: piece.color,
          //   size: 20.0,
          // ),
          Text(
            piece.type.toString(),
            style: GoogleFonts.fredoka(
              textStyle: TextStyle(
                fontSize: piece.type * 5 + 5,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
