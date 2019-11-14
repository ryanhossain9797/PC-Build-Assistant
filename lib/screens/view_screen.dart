import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  static String id = "/viewScreenId";

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("viewScreen"),
      ),
    );
  }
}
