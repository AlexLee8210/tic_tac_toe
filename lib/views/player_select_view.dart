import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:tic_tac_toe/animations/fade_in.dart';
import 'package:tic_tac_toe/widgets/play_button.dart';
import 'package:tic_tac_toe/widgets/selector.dart';
import 'package:tic_tac_toe/views/two_player_game_view.dart';

class PlayerSelectPage extends StatefulWidget {
  const PlayerSelectPage({Key? key}) : super(key: key);

  @override
  State<PlayerSelectPage> createState() => _PlayerSelectPageState();
}

class _PlayerSelectPageState extends State<PlayerSelectPage> {
  static const int p1StartColorIndex = 0, p2StartColorIndex = 5;

  static const List<Color> colors = [
    Color.fromARGB(255, 255, 47, 47),
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.cyanAccent,
    Color.fromARGB(255, 43, 81, 250),
    Color.fromARGB(255, 72, 52, 255),
    Color.fromARGB(255, 237, 133, 255),
  ];

  static const List<IconData> icons = [
    Icons.close_rounded,
    Icons.circle_outlined,
    Icons.favorite,
    //Icons.heart_broken,
    Icons.cloud,
    Icons.star_rounded,
  ];

  // Each Player's icon and color
  late Map<int, IconData> playerIcon;
  late Map<int, Color> playerColor;

  // Color Select
  late Widget p1ColorSelect, p2ColorSelect;
  CarouselController p1ColorCarouselController = CarouselController();
  CarouselController p2ColorCarouselController = CarouselController();

  late Map<int, int> playerPrevColorIndex;

  // Icon Select
  late Widget p1IconSelect, p2IconSelect;
  CarouselController p1IconCarouselController = CarouselController();
  CarouselController p2IconCarouselController = CarouselController();

  late Map<int, int> playerPrevIconIndex;

  @override
  void initState() {
    super.initState();

    p1ColorSelect = Selector(
      onPageChanged: colorPageChanged,
      player: 1,
      items: generateColorPickerList(1),
      carouselController: p1ColorCarouselController,
    );
    p2ColorSelect = Selector(
      onPageChanged: colorPageChanged,
      player: 2,
      items: generateColorPickerList(2),
      carouselController: p2ColorCarouselController,
    );

    playerPrevColorIndex = <int, int>{};

    playerIcon = <int, IconData>{};
    playerColor = <int, Color>{};

    playerColor[1] = colors[p1StartColorIndex];
    playerColor[2] = colors[p2StartColorIndex];

    playerPrevColorIndex[1] = 0;
    playerPrevColorIndex[2] = 5;

    colorPageChanged(0, 1);
    colorPageChanged(0, 2);

    p1IconSelect = Selector(
      onPageChanged: iconPageChanged,
      player: 1,
      items: generateIconPickerList(1),
      carouselController: p1IconCarouselController,
    );
    p2IconSelect = Selector(
      onPageChanged: iconPageChanged,
      player: 2,
      items: generateIconPickerList(2),
      carouselController: p2IconCarouselController,
    );

    playerIcon[1] = icons[0];
    playerIcon[2] = icons[1];

    playerPrevIconIndex = <int, int>{};
    playerPrevIconIndex[1] = icons.length - 1;
    playerPrevIconIndex[2] = 2;
    iconPageChanged(0, 1);
    iconPageChanged(0, 2);
  }

  Color deSaturate(Color color, [double amount = .5]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslSat =
        hsl.withSaturation((hsl.saturation - amount).clamp(0.0, 1.0));

    return hslSat.toColor();
  }

  List<Widget> generateColorPickerList(int startColorIndex,
      [List<Color> colorsList = colors]) {
    return List.generate(
      colors.length,
      (index) => Container(
        width: 100,
        decoration: BoxDecoration(
          color: colorsList[(index + startColorIndex) % colorsList.length],
          border: Border.all(
            color: Colors.white70,
            width: 2,
          ),
          //color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
      ),
    );
  }

  void colorPageChanged(int index, int player) {
    setState(() {
      int playerIndex = (player == 1
              ? (index + p1StartColorIndex)
              : (index + p2StartColorIndex)) %
          colors.length;

      // Generate color picker list with the disabled color
      Color disableColor = deSaturate(colors[playerIndex].withOpacity(0.3));
      List<Color> tempColors = List<Color>.from(colors);
      tempColors[playerIndex] = disableColor;
      List<Widget> tempColorPicker = generateColorPickerList(
        (player == 2 ? p1StartColorIndex : p2StartColorIndex),
        tempColors,
      );

      //set Player Colors
      player == 1
          ? playerColor[1] = colors[playerIndex]
          : playerColor[2] = colors[playerIndex];

      if (colors[playerIndex] ==
          (player == 1 ? playerColor[2] : playerColor[1])) {
        if (playerIndex - (playerPrevColorIndex[player] as int) == 1 ||
            playerIndex - (playerPrevColorIndex[player] as int) ==
                (1 - colors.length)) {
          player == 1
              ? p1ColorCarouselController.nextPage()
              : p2ColorCarouselController.nextPage();
        } else if ((playerPrevColorIndex[player] as int) - playerIndex == 1 ||
            playerIndex - (playerPrevColorIndex[player] as int) ==
                (colors.length - 1)) {
          player == 1
              ? p1ColorCarouselController.previousPage()
              : p2ColorCarouselController.previousPage();
        }
      } else if (player == 1) {
        p1IconSelect = Selector(
          onPageChanged: iconPageChanged,
          player: 1,
          items: generateIconPickerList(1),
          carouselController: p1IconCarouselController,
        );
        p2ColorSelect = Selector(
          onPageChanged: colorPageChanged,
          player: 2,
          items: tempColorPicker,
          carouselController: p2ColorCarouselController,
        );
      } else {
        p2IconSelect = Selector(
          onPageChanged: iconPageChanged,
          player: 2,
          items: generateIconPickerList(2),
          carouselController: p2IconCarouselController,
        );
        p1ColorSelect = Selector(
          onPageChanged: colorPageChanged,
          player: 1,
          items: tempColorPicker,
          carouselController: p1ColorCarouselController,
        );
      }

      playerPrevColorIndex[player] = playerIndex;
    });
  }

  List<Widget> generateIconPickerList(int player) {
    return List.generate(
      icons.length,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color:
                  ((icons[player == 1 ? index : (index + 1) % icons.length] ==
                              playerIcon[player == 1 ? 2 : 1])
                          ? deSaturate(
                              (playerColor[player] as Color).withOpacity(0.4))
                          : playerColor[player] as Color)
                      .withAlpha(100),
              spreadRadius: 1,
              blurRadius: 25.0,
            )
          ],
        ),
        child: Icon(
          icons[player == 1 ? index : (index + 1) % icons.length],
          color: (icons[player == 1 ? index : (index + 1) % icons.length] ==
                  playerIcon[player == 1 ? 2 : 1])
              ? deSaturate((playerColor[player] as Color).withOpacity(0.4))
              : playerColor[player],
          size: 50,
        ),
      ),
    );
  }

  void iconPageChanged(int index, int player) {
    setState(() {
      int playerIndex = player == 1 ? index : (index + 1) % icons.length;
      player == 1
          ? playerIcon[1] = icons[playerIndex]
          : playerIcon[2] = icons[playerIndex];

      // if current player icon equals other player icon
      if (playerIcon[player] == playerIcon[player == 1 ? 2 : 1]) {
        if (playerIndex - (playerPrevIconIndex[player] as int) == 1 ||
            playerIndex - (playerPrevIconIndex[player] as int) ==
                (1 - icons.length)) {
          player == 1
              ? p1IconCarouselController.nextPage()
              : p2IconCarouselController.nextPage();
        } else if ((playerPrevIconIndex[player] as int) - playerIndex == 1 ||
            playerIndex - (playerPrevIconIndex[player] as int) ==
                (icons.length - 1)) {
          player == 1
              ? p1IconCarouselController.previousPage()
              : p2IconCarouselController.previousPage();
        }
      } else if (player == 1) {
        p2IconSelect = Selector(
          onPageChanged: iconPageChanged,
          player: 2,
          items: generateIconPickerList(2),
          carouselController: p2IconCarouselController,
        );
      } else {
        p1IconSelect = Selector(
          onPageChanged: iconPageChanged,
          player: 1,
          items: generateIconPickerList(1),
          carouselController: p1IconCarouselController,
        );
      }

      playerPrevIconIndex[player] = playerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
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
        child: FadeIn(
          duration: const Duration(milliseconds: 1000),
          padding: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Select Icons',
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
                indent: 40,
                endIndent: 40,
              ),
              // const PlayerNameField(
              //   initialText: 'Player 1',
              //   hintText: 'Player 1',
              // ),
              Text(
                'Player 1',
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
              p1IconSelect,
              p1ColorSelect,
              // const PlayerNameField(
              //   initialText: 'Player 2',
              //   hintText: 'Player 2',
              // ),
              Text(
                'Player 2',
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
              p2IconSelect,
              p2ColorSelect,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayButton(
                    buttonText: 'Exit',
                    clickedFunction: () {
                      Navigator.of(context).pop();
                    },
                    iconType: Icons.exit_to_app_rounded,
                    animationDuration: 1500,
                    width: 100,
                  ),
                  PlayButton(
                    buttonText: 'Start Game',
                    clickedFunction: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: GamePage(
                            playerColor: playerColor,
                            playerIcon: playerIcon,
                          ),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    iconType: Icons.play_arrow_rounded,
                    animationDuration: 1500,
                    width: 200,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
