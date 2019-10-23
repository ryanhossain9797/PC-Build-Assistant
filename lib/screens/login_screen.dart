import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pc_build_assistant/components/rounded_button.dart';
import 'package:pc_build_assistant/constants.dart';
import 'package:pc_build_assistant/screens/reset_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/loginScreenId";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";

  bool _busy = false;
  String _message = "";

  @override
  void initState() {
    setState(() {
      _message = "Log In With Email and Password";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        color: kLoginButtonColor,
        inAsyncCall: _busy,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'coolingFan',
                  child: Container(
                    height: 200,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _message,
                    style: TextStyle(color: kLoginButtonColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: kLoginTextFieldDecoration.copyWith(
                      hintText: "Your Email"),
                  onChanged: (email) {
                    _email = email;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: kLoginTextFieldDecoration.copyWith(
                      hintText: "Your Password"),
                  onChanged: (password) {
                    _password = password;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Hero(
                  tag: 'loginButton',
                  child: RoundedButton(
                    title: 'Log In',
                    onPressed: () async {
                      setState(() {
                        _busy = true;
                      });

                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: _email, password: _password);
                        if (user != null) {
                          setState(() {
                            _busy = false;
                          });
                          Navigator.pushNamed(context, HomeScreen.id);
                        }
                      } catch (e) {
                        print(e.toString());
                        setState(() {
                          _busy = false;
                          if (e is PlatformException) {
                            if (e.code == kWrongEmail || e.code == kWrongPass) {
                              _message = "Wrong Email or Password";
                            } else {
                              _message = "Something went wrong";
                            }
                          }
                        });
                      }
                      _emailController.clear();
                      _passwordController.clear();
                    },
                    color: kLoginButtonColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Hero(
                  tag: 'passwordResetButton',
                  child: RoundedButton(
                    title: 'Forgot Password?',
                    onPressed: () async {
                      Navigator.pushNamed(context, ResetScreen.id);
                      _emailController.clear();
                      _passwordController.clear();
                    },
                    color: kRedButtonColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}