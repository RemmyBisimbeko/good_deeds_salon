import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_deeds_salon/Screens/authentication_checker.dart';
import 'package:good_deeds_salon/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

// @override
// void initState() {
//   // super.initState();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.landscapeRight,
//     DeviceOrientation.landscapeLeft,
//   ]);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthenticationChecker(),
      debugShowCheckedModeBanner: false,
    );
  }
}
