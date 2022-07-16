import 'package:flutter/material.dart';

class Piece extends StatelessWidget {
  final double pieceSize;
  final Color pieceColor;

  const Piece({
    required this.pieceSize,
    required this.pieceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: pieceColor,
      size: pieceSize,
      semanticLabel: 'Text to announce in accessibility modes',
    );
  }
}
