import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/arguments/user_screen_arguments.dart';
import 'package:pc_build_assistant/components/pc_component_widget.dart';
import 'package:pc_build_assistant/constants.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
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

  static List<PCComponentModel> components = new List<PCComponentModel>();

  PageController _pageController = PageController();
  @override
  void initState() {
    getCurrentUser();
    getData();
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

  getData() async {
    print("called getdata");
    Firestore database = Firestore.instance;
    try {
      List<Map<String, dynamic>> componentList;
      QuerySnapshot collection =
          await database.collection('pc-components').getDocuments();
      List<DocumentSnapshot> documents = collection.documents;
      componentList = documents.map((DocumentSnapshot snapshot) {
        return snapshot.data;
      }).toList();
      components.clear();
      for (Map<String, dynamic> item in componentList) {
        setState(
          () {
            components.add(
              PCComponentModel(
                manufacturer: item["manufacturer"],
                name: item["name"],
                description: item["description"],
                imgurl: item["imgurl"],
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e.toString());
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
                  await Navigator.pushNamed(
                    context,
                    UserScreen.id,
                    arguments: UserScreenArguments(
                      Image.network(
                        Gravatar(_currentUser.email).imageUrl(
                          defaultImage: GravatarImage.retro,
                          size: 300,
                          fileExtension: true,
                        ),
                      ),
                    ),
                  );
                }
                getCurrentUser();
              },
              child: Hero(
                tag: "avatar",
                child: _currentUser != null
                    ? CircleAvatar(
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
                        backgroundColor: Colors.transparent,
                        foregroundColor: Color(0xFFFFFFFF),
                        child: Icon(
                          FontAwesomeIcons.user,
                          size: 20,
                        ),
                      ),
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
              components.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: components.length,
                        itemBuilder: (context, index) {
                          return PCComponent(
                            component: components[index],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text("Loading"),
                    ),
              components.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        itemCount: components.length,
                        itemBuilder: (context, index) {
                          return PCComponent(
                            component: components[index],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text("Loading"),
                    ),
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
