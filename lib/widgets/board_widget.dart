import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  final List<Widget> gameBoard;

  const BoardWidget({
    Key? key,
    required this.gameBoard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 50, right: 50),
        width: double.infinity,
        height: 350.0,
        child: GridView.count(
          crossAxisCount: 3,
          children: gameBoard,
        ),
      ),
    );
  }
}
