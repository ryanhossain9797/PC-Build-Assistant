import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pc_build_assistant/components/rounded_button.dart';
import 'package:pc_build_assistant/constants.dart';
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
    return Scaffold(
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
              ClipOval(
                child: _currentUser != null
                    ? CircleAvatar(
                        radius: 80,
                        child: ClipOval(
                          child: Image.network(
                            Gravatar(_currentUser.email).imageUrl(
                              defaultImage: GravatarImage.retro,
                              size: 300,
                              fileExtension: true,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundColor: kLoginButtonColor,
                        foregroundColor: Color(0xFFFFFFFF),
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
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
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.arrow_forward),
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
