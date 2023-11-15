import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_deeds_salon/Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp(
      title: 'Good Deeds Salon',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
