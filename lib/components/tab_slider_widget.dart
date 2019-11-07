import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/util/constants.dart';

class TabSlider extends StatelessWidget {
  final bool left;
  final Duration duration;
  final double width;
  final double height;
  final Color colorLeft;
  final Color colorRight;

  TabSlider({
    this.left = true,
    this.duration = const Duration(milliseconds: 100),
    this.width = 100,
    this.height = 100,
    this.colorLeft = Colors.white,
    this.colorRight = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: left ? colorLeft : colorRight,
        borderRadius: BorderRadius.only(
          topLeft: left ? Radius.circular(kRadius / 2) : Radius.zero,
          bottomLeft: left ? Radius.circular(kRadius / 2) : Radius.zero,
          topRight: !left ? Radius.circular(kRadius / 2) : Radius.zero,
          bottomRight: !left ? Radius.circular(kRadius / 2) : Radius.zero,
        ),
      ),
    );
  }
}
