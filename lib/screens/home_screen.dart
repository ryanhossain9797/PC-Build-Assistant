import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/components/pc_component.dart';
import 'package:pc_build_assistant/components/rounded_button.dart';
import 'package:pc_build_assistant/constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = "/homeScreenId";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  String userName = "No One Logged In";
  int _index = 0;

  GlobalKey _componentsKey = GlobalKey();
  GlobalKey _buildKey = GlobalKey();

  RenderBox _componentBox;
  double _tabWidth = 0;
  double _tabHeight = 0;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initialSize());
  }

  initialSize() {
    _componentBox = _componentsKey.currentContext.findRenderObject();
    upDateSize();
  }

  upDateSize() {
    Size tabSize = _componentBox.size;
    setState(() {
      _tabWidth = tabSize.width;
      _tabHeight = tabSize.height;
    });
  }

  getCurrentUser() async {
    FirebaseUser user;
    try {
      user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          _currentUser = user;
          userName = _currentUser.email;
        });
      }
    } catch (excp) {
      print("error occured $excp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PC Build Assistant",
          style: TextStyle(fontFamily: "Rodin"),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: 50,
          child: Stack(
            children: <Widget>[
              AnimatedAlign(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 300),
                alignment:
                    _index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _tabWidth,
                  height: _tabHeight,
                  decoration: BoxDecoration(
                    color: kLoginButtonColor,
                    borderRadius: BorderRadius.only(
                      topLeft: _index == 1 ? Radius.circular(30) : Radius.zero,
                      topRight: _index == 0 ? Radius.circular(30) : Radius.zero,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        key: _componentsKey,
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.shoppingCart,
                            size: _index == 0 ? 22 : 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _index = 0;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        key: _buildKey,
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.screwdriver,
                            size: _index == 1 ? 22 : 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _index = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text("username: " + userName),
            ),
            Expanded(
              child: IndexedStack(
                index: _index,
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      PCComponent(title: "First 1"),
                      PCComponent(title: "First 2"),
                      PCComponent(title: "First 3"),
                    ],
                  ),
                  ListView(
                    children: <Widget>[
                      PCComponent(title: "Second 1"),
                      PCComponent(title: "Second 2"),
                      PCComponent(title: "Second 3"),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Hero(
                tag: 'signoutButton',
                child: RoundedButton(
                  title: 'Sign Out',
                  onPressed: () async {
                    await _auth.signOut();

                    Navigator.pop(context);
                  },
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
