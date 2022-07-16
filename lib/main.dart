import 'package:flutter/material.dart';

import './piece.dart';

void main() {
  runApp(const MyApp());
}

Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: List.generate(
      10,
      (index) {
        return Center(
          child: Text(
            'Item $index',
          ),
        );
      },
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Foe'),
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
                            pieceSize: 24 + (index / 2) * 12.0,
                            pieceColor: Colors.red,
                          ))),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      6,
                      (index) => Piece(
                            pieceSize: 24 + (index / 2) * 12.0,
                            pieceColor: Colors.blue,
                          ))),
            ],
          ),
        ),
      ),
    );
  }
}
