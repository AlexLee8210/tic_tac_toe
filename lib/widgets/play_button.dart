import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? clickedFunction;
  final IconData iconType;
  final int animationDuration;
  final double width;

  const PlayButton({
    Key? key,
    required this.buttonText,
    required this.clickedFunction,
    required this.iconType,
    required this.animationDuration,
    this.width = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.cyan,
              Colors.blueAccent,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 5.0,
            )
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: width,
        height: 50,
        child: OutlinedButton.icon(
          icon: Icon(
            iconType,
            color: clickedFunction == null ? Colors.black54 : Colors.white,
          ),
          style: OutlinedButton.styleFrom(
            primary: Colors.transparent,
            onSurface: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onPressed: clickedFunction,
          label: Text(
            buttonText,
            style: GoogleFonts.fredoka(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: clickedFunction == null ? Colors.black54 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
