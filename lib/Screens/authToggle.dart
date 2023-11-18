import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/login_screen.dart';
import 'package:good_deeds_salon/Screens/signup_screen.dart';

void main() => runApp(const AuthToggle());

class AuthToggle extends StatefulWidget {
  const AuthToggle({Key? key}) : super(key: key);

  @override
  AuthToggleState createState() => AuthToggleState();
}

class AuthToggleState extends State<AuthToggle> {
  bool revealLoginScreen = true;

  void toggleAuthScreens() {
    setState(() {
      revealLoginScreen = !revealLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (revealLoginScreen) {
      return LoginScreen(revealSignupScreen: toggleAuthScreens);
    } else {
      return SignupScreen(revealLoginScreen: toggleAuthScreens);
    }
  }
}
