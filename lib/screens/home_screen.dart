import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_build_assistant/arguments/user_screen_arguments.dart';
import 'package:pc_build_assistant/components/build_component_widget.dart';
import 'package:pc_build_assistant/components/pc_component_widget.dart';
import 'package:pc_build_assistant/components/tab_button_widget.dart';
import 'package:pc_build_assistant/components/tab_slider_widget.dart';
import 'package:pc_build_assistant/logic/build_manager.dart';
import 'package:pc_build_assistant/models/pc_component.dart';
import 'package:pc_build_assistant/screens/login_screen.dart';
import 'package:pc_build_assistant/screens/user_screen.dart';
import 'package:pc_build_assistant/storage/database_helper.dart';
import 'package:pc_build_assistant/util/constants.dart';
import 'package:pc_build_assistant/util/decoration.dart';
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

  static List<PCComponent> _components = new List<PCComponent>();

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
    List<PCComponent> tempComponents = await DatabaseHelper.getData();
    setState(() {
      _components.clear();
      _components.addAll(tempComponents);
    });
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
          Theme(
            data: Theme.of(context).copyWith(accentColor: kLoginButtonColor),
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  _index = index;
                });
              },
              controller: _pageController,
              pageSnapping: true,
              children: <Widget>[
                _components.length > 0
                    ? ComponentPage(
                        onRefresh: () {
                          getData();
                        },
                        components: _components,
                      )
                    : Center(
                        child: TyperAnimatedTextKit(
                          text: ["Loading"],
                          duration: Duration(milliseconds: 600),
                          textStyle: loadingAnimationStyle,
                        ),
                      ),
                BuildPageAnimated(
                  onRefresh: () {
                    getData();
                  },
                ),
              ],
            ),
          ),

          //---------------------------------------------BOTTOM NAVBAR---------------------------------------------
          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  spreadRadius: 20,
                  color: kNavShadowColor,
                  offset: Offset(0, 10),
                ),
              ],
            ),
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
                  child: TabSlider(
                    left: _index == 0 ? true : false,
                    duration: kAnimationDuration,
                    width: _tabWidth,
                    height: _tabHeight,
                    color: kTabSliderColor,
                  ),
                ),

                //-------------------------------------TOP ICONS------------------------------------------
                Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: TabButton(
                          componentsKey: _componentsKey,
                          selected: _index == 0 ? true : false,
                          icon: FontAwesomeIcons.shoppingCart,
                        ),
                        onTap: () {
                          setState(
                            () {
                              _index = 0;
                              _pageController.animateToPage(0,
                                  duration: kAnimationDuration,
                                  curve: Curves.decelerate);
                            },
                          );
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
                        child: TabButton(
                          componentsKey: _buildKey,
                          selected: _index == 1 ? true : false,
                          icon: FontAwesomeIcons.screwdriver,
                        ),
                        onTap: () {
                          setState(
                            () {
                              _index = 1;
                              _pageController.animateToPage(1,
                                  duration: kAnimationDuration,
                                  curve: Curves.decelerate);
                            },
                          );
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

//---------------------------------------------------------------PAGES--------------------------------------------------------------
typedef Refresh();

//----------------------------------------------------------COMPONENTS PAGE---------------------------------------------------------
class ComponentPage extends StatefulWidget {
  final Refresh onRefresh;
  final List<PCComponent> components;

  ComponentPage({this.onRefresh, this.components});

  @override
  _ComponentPageState createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  @override
  Widget build(BuildContext context) {
    var components = widget.components;
    return RefreshIndicator(
      color: kLoginButtonColor,
      onRefresh: () async {
        widget.onRefresh();
      },
      child: ListView.builder(
        itemCount: components.length,
        itemBuilder: (context, index) {
          double top = 5;
          double bottom = 5;
          if (index == 0) top += 30;
          if (index == components.length - 1) bottom += 50;
          return Container(
            margin:
                EdgeInsets.only(left: 10, right: 10, top: top, bottom: bottom),
            child: PCComponentWidget(
              component: components[index],
              onAdd: (currentComponent) {
                BuildManager.addComponent(currentComponent);
              },
            ),
          );
        },
      ),
    );
  }
}

//------------------------------------------------------------------BUILD PAGE------------------------------------------------------------------
class BuildPage extends StatefulWidget {
  final Refresh onRefresh;
  BuildPage({this.onRefresh});

  @override
  _BuildPageState createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kLoginButtonColor,
      onRefresh: () async {
        widget.onRefresh();
      },
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: kLoginButtonColor),
        child: ListView(
          children: <Widget>[
            BuildManager.build.chassis != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: BuildComponentWidget(
                      title: "Chassis",
                      component: BuildManager.build.chassis,
                      onRemove: (removeComponent) {
                        setState(() {
                          BuildManager.build.chassis = null;
                        });
                      },
                    ),
                  )
                : Container(),
            BuildManager.build.motherboard != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: BuildComponentWidget(
                      title: "Motherboard",
                      component: BuildManager.build.motherboard,
                      onRemove: (removeComponent) {
                        setState(() {
                          BuildManager.build.motherboard = null;
                        });
                      },
                    ),
                  )
                : Container(),
            BuildManager.build.processor != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: BuildComponentWidget(
                      title: "Processor",
                      component: BuildManager.build.processor,
                      onRemove: (removeComponent) {
                        setState(() {
                          BuildManager.build.processor = null;
                        });
                      },
                    ),
                  )
                : Container(),
            BuildManager.build.gpu != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: BuildComponentWidget(
                      title: "Graphics  Card",
                      component: BuildManager.build.gpu,
                      onRemove: (removeComponent) {
                        setState(() {
                          BuildManager.build.gpu = null;
                        });
                      },
                    ),
                  )
                : Container(),
            BuildManager.build.psu != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: BuildComponentWidget(
                      title: "Power Supply",
                      component: BuildManager.build.psu,
                      onRemove: (removeComponent) {
                        setState(() {
                          BuildManager.build.psu = null;
                        });
                      },
                    ),
                  )
                : Container(),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------BUILD PAGE ANIMATED-------------------------------------------------------------
class BuildPageAnimated extends StatefulWidget {
  final Refresh onRefresh;
  BuildPageAnimated({this.onRefresh});

  @override
  _BuildPageAnimatedState createState() => _BuildPageAnimatedState();
}

class _BuildPageAnimatedState extends State<BuildPageAnimated> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kLoginButtonColor,
      onRefresh: () async {
        widget.onRefresh();
      },
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: kLoginButtonColor),
        child: AnimatedList(
          initialItemCount: BuildManager.getItemCount(),
          itemBuilder: (context, itemNumber, animation) {
            PCComponent component = BuildManager.getItem(itemNumber);
            double top = 5;
            double bottom = 5;
            if (itemNumber == BuildManager.getItemCount() - 1) bottom += 50;
            return Container(
              margin: EdgeInsets.only(
                  left: 10, right: 10, top: top, bottom: bottom),
              child: BuildComponentWidget(
                title: PCComponent.getTitle(component),
                component: component,
                onRemove: (PCComponent removeComponent) {
                  BuildManager.removeComponent(removeComponent);
                  AnimatedList.of(context).removeItem(
                    itemNumber,
                    (context, animation) {
                      BuildManager.removeComponent(removeComponent);
                      return FadeTransition(
                        opacity: animation.drive(
                          Tween(begin: 0, end: 1),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: top, bottom: bottom),
                          child: BuildComponentWidget(
                            component: removeComponent,
                            title: PCComponent.getTitle(component),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
