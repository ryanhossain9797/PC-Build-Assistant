import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton(
      {Key key,
      @required GlobalKey<State<StatefulWidget>> componentsKey,
      @required int index,
      @required IconData icon})
      : _componentsKey = componentsKey,
        _index = index,
        _icon = icon,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _componentsKey;
  final int _index;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _componentsKey,
      child: Center(
        child: Icon(
          _icon,
          size: _index == 0 ? 22 : 20,
        ),
      ),
    );
  }
}
