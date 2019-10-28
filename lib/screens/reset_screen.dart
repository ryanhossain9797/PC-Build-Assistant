import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pc_build_assistant/components/rounded_button.dart';
import 'package:pc_build_assistant/constants.dart';

//import 'home_screen.dart';

class ResetScreen extends StatefulWidget {
  static String id = "/resetScreenId";

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  bool _busy = false;
  String _message = "";

  @override
  void initState() {
    setState(() {
      _message = "Enter your Email";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: TextStyle(fontFamily: "Rodin"),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                    style: TextStyle(color: kRedButtonColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: kResetTextFieldDecoration.copyWith(
                      hintText: "Your Email"),
                  onChanged: (email) {
                    _email = email;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Hero(
                  tag: 'passwordResetButton',
                  child: RoundedButton(
                    title: 'Reset Password',
                    onPressed: () async {
                      setState(() {
                        _busy = true;
                      });

                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: _email, password: "0");
                        if (newUser != null) {
                          setState(() {
                            _busy = false;
                          });
                          Navigator.pushNamed(context, "0");
                        }
                      } catch (e) {
                        print(e.toString());
                        setState(() {
                          _busy = false;
                        });
                        if (e is PlatformException) {
                          if (e.code == kWrongPass) {
                            try {
                              await _auth.sendPasswordResetEmail(email: _email);
                              setState(() {
                                _message = "Password Reset mail sent";
                              });
                            } catch (e) {
                              print(e);
                              setState(() {
                                _message = "Something went wrong";
                              });
                            }
                          } else {
                            setState(() {
                              _message = "Something went wrong";
                            });
                          }
                        }
                      }
                      _emailController.clear();
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
