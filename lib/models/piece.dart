import 'package:flutter/material.dart';

class Piece {
  final int type;
  final Color color;
  final int player;
  final IconData icon;
  final double? size;

  const Piece({
    required this.type,
    required this.color,
    required this.player,
    required this.icon,
    this.size,
  });

  // NOTE: implementing functionality here in the next step!
}
