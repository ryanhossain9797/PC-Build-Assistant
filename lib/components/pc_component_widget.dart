import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/constants.dart';
import 'package:pc_build_assistant/models/pc_component.dart';

class PCComponent extends StatelessWidget {
  final PCComponentModel component;
  const PCComponent({Key key, @required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(kRadius),
          ),
          border: Border.all(width: 2.0, color: kContinueButtonColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  component.imgurl,
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
                  onPressed: () {},
                )
              ],
            ),
          ],
        ));
  }
}
