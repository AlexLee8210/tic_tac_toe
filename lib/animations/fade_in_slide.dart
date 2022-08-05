import 'package:flutter/material.dart';

class FadeInSlide extends StatelessWidget {
  final Widget? child;
  final Duration duration;
  final int padding;

  const FadeInSlide({
    Key? key,
    required this.child,
    required this.duration,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween<double>(
        begin: 0,
        end: 1,
      ),
      builder: (BuildContext context, double val, Widget? child) {
        return Opacity(
          opacity: val,
          child: Padding(
            padding: EdgeInsets.only(bottom: val * padding),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
