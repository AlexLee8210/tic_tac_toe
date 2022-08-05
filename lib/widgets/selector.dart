import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Selector extends StatelessWidget {
  final Function(int, int) onPageChanged;
  final int player;
  final List<Widget> items;
  final CarouselController carouselController;

  const Selector({
    Key? key,
    required this.onPageChanged,
    required this.player,
    required this.items,
    required this.carouselController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CarouselSlider(
              options: CarouselOptions(
                height: 70.0,
                viewportFraction: 0.25,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  //if (onPageChanged == null) return;
                  onPageChanged(index, player);
                },
              ),
              items: items,
              carouselController: carouselController),
        ),
        Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
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
      ],
    );
  }
}
