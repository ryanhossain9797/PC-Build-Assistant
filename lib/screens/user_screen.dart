import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/arguments/user_screen_arguments.dart';
import 'package:pc_build_assistant/components/rounded_button_widget.dart';
import 'package:pc_build_assistant/screens/add_component_screen.dart';
import 'package:pc_build_assistant/util/constants.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class UserScreen extends StatefulWidget {
  static String id = "/userScreenId";
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    FirebaseUser user;
    try {
      user = await _auth.currentUser();
      setState(() {
        _currentUser = user;
      });
    } catch (excp) {
      print("error occured $excp");
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserScreenArguments _args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButton: _currentUser != null
          ? (_currentUser.email == "ryanhossain9797@gmail.com"
              ? FloatingActionButton(
                  backgroundColor: kLoginButtonColor,
                  onPressed: () {
                    Navigator.pushNamed(context, AddScreen.id);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                )
              : null)
          : null,
      appBar: AppBar(
        title: Text(
          _currentUser != null ? _currentUser.email : "User",
          style: TextStyle(fontFamily: "Rodin"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "avatar",
                child: CircleAvatar(
                  radius: 80,
                  child: ClipOval(
                      child: _currentUser != null
                          ? Image.network(
                              Gravatar(_currentUser.email).imageUrl(
                                defaultImage: GravatarImage.retro,
                                size: 300,
                                fileExtension: true,
                              ),
                            )
                          : _args.avatar),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: kLoginButtonColor,
                      foregroundColor: Color(0xFFFFFFFF),
                      radius: 30,
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.arrow_back),
                    ),
                    CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.asset('images/gravatar.jpg'),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "PC Build Assistant",
                    style: TextStyle(fontFamily: "Rodin", fontSize: 20),
                  ),
                  Text("Uses Gravatar for your Avatar"),
                  Text("Visit Gravatar to set your Avatar for your Email"),
                ],
              ),
              RoundedButton(
                color: kRedButtonColor,
                title: "Sign Out",
                onPressed: () {
                  _auth.signOut();
                  getCurrentUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
