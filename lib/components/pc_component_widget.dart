import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/util/constants.dart';

typedef OnComponentSelected(PCComponent component);

class PCComponentWidget extends StatelessWidget {
  final PCComponent component;
  final OnComponentSelected onAdd;
  final OnComponentSelected onView;
  PCComponentWidget(
      {Key key, @required this.component, this.onAdd, this.onView})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    CachedNetworkImageProvider img = CachedNetworkImageProvider(
      component.imgurl,
    );
    return Container(
        padding: EdgeInsets.all(10),
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
                Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRadius),
                        color: kLoginButtonColor,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          onAdd(component);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kRadius),
                        color: kLoginButtonColor,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.open_in_new),
                        onPressed: () {
                          onView(component);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
