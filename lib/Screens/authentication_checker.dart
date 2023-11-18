import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/home_screens.dart';

import 'authToggle.dart';

void main() => runApp(const AuthenticationChecker());

class AuthenticationChecker extends StatelessWidget {
  const AuthenticationChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthToggle();
          }
        },
      ),
    );
  }
}
