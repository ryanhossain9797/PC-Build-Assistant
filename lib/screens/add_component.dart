import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pc_build_assistant/components/rounded_button_widget.dart';
import 'package:pc_build_assistant/constants.dart';

class AddScreen extends StatefulWidget {
  static String id = "/addScreenId";

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _manufacturer = "";
  String _name = "";
  String _description = "";
  String _imgurl;
  Firestore _storage = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "Manufacturer"),
              onChanged: (manufacturer) {
                _manufacturer = manufacturer;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Name"),
              onChanged: (name) {
                _name = name;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              onChanged: (description) {
                _description = description;
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Image Url"),
              onChanged: (imgurl) {
                _imgurl = imgurl;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RoundedButton(
                title: "Add",
                color: kRegisterButtonColor,
                onPressed: () {
                  _storage.collection('pc-components').add(
                    {
                      "manufacturer": _manufacturer,
                      "name": _name,
                      "description": _description,
                      "imgurl": _imgurl,
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
