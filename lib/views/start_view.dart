import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'player_select_view.dart';
import 'package:tic_tac_toe/widgets/play_button.dart';
import 'package:tic_tac_toe/widgets/game_title.dart';
import 'package:tic_tac_toe/animations/fade_in_slide.dart';
import 'package:tic_tac_toe/views/single_player_view.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
          width: double.infinity,
          height: double.infinity,
          child: FadeInSlide(
            duration: const Duration(milliseconds: 1000),
            padding: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(flex: 5),
                const GameTitle(title: 'Dick Dack Doe'),
                const Spacer(flex: 1),
                PlayButton(
                  buttonText: 'Single Player',
                  clickedFunction: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const SinglePlayerPage(
                          playerColor: {1: Colors.red, 2: Colors.blue},
                          playerIcon: {1: Icons.close, 2: Icons.circle},
                        ),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  iconType: Icons.person,
                  animationDuration: 1500,
                ),
                const PlayButton(
                  buttonText: 'Online',
                  clickedFunction: null,
                  iconType: Icons.wifi_rounded,
                  animationDuration: 1500,
                ),
                PlayButton(
                  buttonText: 'Pass n\' Play',
                  clickedFunction: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const PlayerSelectPage(),
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  iconType: Icons.ad_units,
                  animationDuration: 1500,
                ),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
