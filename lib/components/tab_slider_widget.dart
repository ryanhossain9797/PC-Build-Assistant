import 'package:flutter/material.dart';

class TabSlider extends StatelessWidget {
  final bool left;
  final Duration duration;
  final double width;
  final double height;
  final Color color;

  TabSlider({
    this.left = true,
    this.duration = const Duration(milliseconds: 100),
    this.width = 100,
    this.height = 100,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: !left ? Radius.circular(30) : Radius.zero,
          topRight: left ? Radius.circular(30) : Radius.zero,
        ),
      ),
    );
  }
}
