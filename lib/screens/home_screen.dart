import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/components/pc_component.dart';
import 'package:pc_build_assistant/components/rounded_button.dart';
import 'package:pc_build_assistant/constants.dart';
import 'package:pc_build_assistant/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = "/homeScreenId";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  String _userName;
  int _index = 0;

  GlobalKey _componentsKey = GlobalKey();
  GlobalKey _buildKey = GlobalKey();

  RenderBox _componentBox;
  double _tabWidth = 0;
  double _tabHeight = 0;

  PageController _pageController = PageController();
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
          _userName = _currentUser.email;
        });
      }
    } catch (excp) {
      print("error occured $excp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------------------------------------------APP BAR---------------------------------------------------
      appBar: AppBar(
        title: Text(
          "PC Build Assistant",
          style: TextStyle(fontFamily: "Rodin"),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (_currentUser == null) {
                  await Navigator.pushNamed(context, LoginScreen.id);
                  getCurrentUser();
                }
              },
              child: CircleAvatar(
                backgroundColor: kContinueButtonColor,
                child: _userName != null
                    ? Text(
                        _userName.substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
              ),
            ),
          )
        ],
      ),

      //------------------------------------------ BOTTOM NAVBAR--------------------------------------------------
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: 50,
          child: Stack(
            children: <Widget>[
              //----------------------------------TAB BUTTON------------------------------------------------------
              AnimatedAlign(
                curve: Curves.decelerate,
                duration: kAnimationDuration,
                alignment:
                    _index == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: AnimatedContainer(
                  duration: kAnimationDuration,
                  width: _tabWidth,
                  height: _tabHeight,
                  decoration: BoxDecoration(
                    color: kContinueButtonColor,
                    borderRadius: BorderRadius.only(
                      topLeft: _index == 1 ? Radius.circular(30) : Radius.zero,
                      topRight: _index == 0 ? Radius.circular(30) : Radius.zero,
                    ),
                  ),
                ),
              ),

              //-------------------------------------TOP ICONS------------------------------------------
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
                          _pageController.animateToPage(0,
                              duration: kAnimationDuration,
                              curve: Curves.decelerate);
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
                          _pageController.animateToPage(1,
                              duration: kAnimationDuration,
                              curve: Curves.decelerate);
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

      //---------------------------------------BODY OF APP----------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            //-----------------------------------MAIN PAGES----------------------------------------
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              controller: _pageController,
              pageSnapping: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      PCComponent(title: "First 1"),
                      PCComponent(title: "First 2"),
                      PCComponent(title: "First 3"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      PCComponent(title: "Second 1"),
                      PCComponent(title: "Second 2"),
                      PCComponent(title: "Second 3"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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
    );
  }
}
