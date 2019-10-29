import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/constants.dart';

class PCComponent extends StatelessWidget {
  final String title;
  const PCComponent({Key key, @required this.title}) : super(key: key);

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
                  "https://www.evga.com/articles/00795/images/hero/780Ti_HeroCombo.png",
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
                          "EVGA",
                          style: TextStyle(fontFamily: "Rodin", fontSize: 20),
                        ),
                        Text(
                          "EVGA Gtx 780ti Founder's Edition",
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
                      Text("VRAM: 3GB"),
                      Text("TDP: 150Watts")
                    ],
                  ),
                ),
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadius)),
                  fillColor: Colors.green,
                  child: Icon(Icons.add),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ));
  }
}
