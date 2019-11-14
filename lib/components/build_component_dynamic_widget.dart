import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/util/constants.dart';

typedef OnComponentRemove(PCComponent component);

class BuildComponentAdaptiveWidget extends StatelessWidget {
  final PCComponent component;
  final OnComponentRemove onRemove;
  final String title;
  BuildComponentAdaptiveWidget(
      {Key key, @required this.component, this.title = "Title", this.onRemove})
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
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                title,
                style: kAnimatedTextStyle,
              ),
            ),
          ),
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
                      color: kRegisterButtonColor,
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        if (onRemove != null) {
                          onRemove(component);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
