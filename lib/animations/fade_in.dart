import 'package:flutter/material.dart';

class FadeIn extends StatelessWidget {
  final Widget? child;
  final Duration duration;
  final int padding;

  const FadeIn({
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
          child: child,
        );
      },
      child: child,
    );
  }
}
