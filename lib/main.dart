import 'package:flutter/material.dart';

import './piece.dart';
import './board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dick Dack Doe'),
        ),
        body: Container(
          height: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => Piece(
                    pieceType: ((index + 1) / 2.0).round(),
                    pieceColor: Colors.red,
                  ),
                ),
              ),
              Board(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => Piece(
                    pieceType: ((index + 1) / 2.0).round(),
                    pieceColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
