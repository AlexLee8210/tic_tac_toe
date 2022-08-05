import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../views/start_view.dart';
import 'package:tic_tac_toe/animations/fade_in_slide.dart';

class GameEndPopUp extends StatelessWidget {
  final int winner;
  const GameEndPopUp({
    Key? key,
    required this.winner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInSlide(
      duration: const Duration(milliseconds: 1000),
      padding: 20,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 40.0),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                winner == 0 ? 'Tied Game!' : 'Player $winner won!',
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(
                    fontSize: 36,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.cyan,
                      Colors.blueAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)),
                ),
                child: TextButton.icon(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const StartPage(),
                      ),
                    );
                  },
                  label: Text(
                    "Home Screen",
                    style: GoogleFonts.fredoka(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
