import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/util/constants.dart';

typedef OnComponentAdd(PCComponent component);

class PCComponentWidget extends StatelessWidget {
  final PCComponent component;
  final OnComponentAdd onAdd;
  PCComponentWidget({Key key, @required this.component, this.onAdd})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    NetworkImage img = NetworkImage(component.imgurl);
    img.evict();
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: kComponentBoxColor,
          boxShadow: [
            BoxShadow(
              color: Color(0x44000000),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(kRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: img,
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          component.manufacturer,
                          style: TextStyle(fontFamily: "Rodin", fontSize: 20),
                        ),
                        Text(
                          component.name,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        component.description,
                      ),
                    ],
                  ),
                ),
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadius)),
                  fillColor: kLoginButtonColor,
                  child: Icon(Icons.add),
                  onPressed: () {
                    onAdd(component);
                  },
                )
              ],
            ),
          ],
        ));
  }
}
