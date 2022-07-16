import 'package:flutter/material.dart';

class Piece extends StatelessWidget {
  final int pieceType;
  final Color pieceColor;

  const Piece({
    required this.pieceType,
    required this.pieceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          Icons.circle,
          color: pieceColor,
          size: 10 + pieceType * 20.0,
        ),
        Text(
          pieceType.toString(),
          style: TextStyle(fontSize: pieceType * 5 + 10, color: Colors.white),
        ),
      ],
    );
  }
}
