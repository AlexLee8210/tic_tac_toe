import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'views/start_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return isFinished
    //     ? const GameEndPage()
    //     : GamePage(
    //         gameBoard: gameBoard,
    //         p1Pieces: p1Pieces,
    //         p2Pieces: p2Pieces,
    //         gbPieces: gbPieces,
    //         p1Turn: p1Turn);

    // return AnimatedSplashScreen(
    //   splash: const Splash(),
    //   nextScreen: const StartPage(),
    //   splashTransition: SplashTransition.rotationTransition,
    // );

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: Icons.abc,
        nextScreen: const StartPage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
