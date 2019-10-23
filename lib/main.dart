import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/reset_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: ThemeData.dark().scaffoldBackgroundColor,
  ));
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0.0,
      )),
      darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0.0,
      )),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ResetScreen.id: (context) => ResetScreen(),
      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
