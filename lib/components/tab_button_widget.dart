import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton(
      {Key key,
      @required GlobalKey<State<StatefulWidget>> componentsKey,
      @required bool selected,
      @required IconData icon})
      : _componentsKey = componentsKey,
        _selected = selected,
        _icon = icon,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _componentsKey;
  final bool _selected;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _componentsKey,
      child: Center(
        child: Icon(
          _icon,
          size: _selected ? 22 : 20,
        ),
      ),
    );
  }
}
