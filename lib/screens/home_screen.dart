import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/components/pc_component.dart';
import 'package:pc_build_assistant/constants.dart';
import 'package:pc_build_assistant/screens/login_screen.dart';
import 'package:pc_build_assistant/screens/user_screen.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class HomeScreen extends StatefulWidget {
  static String id = "/homeScreenId";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
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
                } else {
                  await Navigator.pushNamed(context, UserScreen.id);
                }
                getCurrentUser();
              },
              child: _currentUser != null
                  ? CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          Gravatar(_currentUser.email).imageUrl(
                            defaultImage: GravatarImage.retro,
                            fileExtension: true,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: kLoginButtonColor,
                      foregroundColor: Color(0xFFFFFFFF),
                      child: Icon(Icons.person),
                    ),
            ),
          )
        ],
      ),

      //---------------------------------------BODY OF APP----------------------------------------------
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
            controller: _pageController,
            pageSnapping: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: <Widget>[
                    PCComponent(title: "First 1"),
                    PCComponent(title: "First 2"),
                    PCComponent(title: "First 3"),
                    PCComponent(title: "First 4"),
                    PCComponent(title: "First 5"),
                    PCComponent(title: "First 6"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: <Widget>[
                    PCComponent(title: "Second 1"),
                    PCComponent(title: "Second 2"),
                    PCComponent(title: "Second 3"),
                    PCComponent(title: "Second 4"),
                    PCComponent(title: "Second 5"),
                    PCComponent(title: "Second 6"),
                  ],
                ),
              )
            ],
          ),

          //---------------------------------------------BOTTOM NAVBAR---------------------------------------------
          Container(
            height: 50,
            child: Stack(
              children: <Widget>[
                //----------------------------------TAB BUTTON------------------------------------------------------
                AnimatedAlign(
                  curve: Curves.decelerate,
                  duration: kAnimationDuration,
                  alignment: _index == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: kAnimationDuration,
                    width: _tabWidth,
                    height: _tabHeight,
                    decoration: BoxDecoration(
                      color: kTabButtonColor,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            _index == 1 ? Radius.circular(30) : Radius.zero,
                        topRight:
                            _index == 0 ? Radius.circular(30) : Radius.zero,
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
        ],
      ),
    );
  }
}
