import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  int index = 0;

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
          userName = user.email;
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
        title: Text("PC Build Assistant"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          height: 50,
          child: Stack(
            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color:
//                            index == 0 ? kLoginButtonColor : Colors.transparent,
//                        borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(kRadius),
//                          topRight: Radius.circular(kRadius),
//                        ),
//                      ),
//                    ),
//                  ),
//                  Container(
//                    width: 4,
//                  ),
//                  Expanded(
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color:
//                            index == 1 ? kLoginButtonColor : Colors.transparent,
//                        borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(kRadius),
//                          topRight: Radius.circular(kRadius),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
              AnimatedAlign(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 200),
                alignment:
                    index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: _tabWidth,
                  height: _tabHeight,
                  decoration: BoxDecoration(
                    color: kLoginButtonColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kRadius),
                      topRight: Radius.circular(kRadius),
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
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 100),
                            style: index == 0
                                ? TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)
                                : TextStyle(fontSize: 14),
                            child: Text("Components"),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 4,
                  ),
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        key: _buildKey,
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 100),
                            style: index == 1
                                ? TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)
                                : TextStyle(fontSize: 14),
                            child: Text("My Build"),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          index = 1;
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
                index: index,
                children: <Widget>[
                  Center(
                    child: Text("First"),
                  ),
                  Center(
                    child: Text("Second"),
                  ),
                ],
              ),
            ),
            SizedBox.fromSize(size: Size(1, 20)),
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
