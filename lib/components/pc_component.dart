import 'package:flutter/material.dart';
import 'package:pc_build_assistant/constants.dart';

class PCComponent extends StatelessWidget {
  final String title;
  const PCComponent({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: kLoginButtonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(kRadius),
        ),
      ),
      height: 200,
      child: Center(child: Text(title)),
    );
  }
}
