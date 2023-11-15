import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FocusNode _textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus on the text field when the screen is shown
    // FocusScope.of(context).requestFocus(_textFocus);
  }

  @override
  void dispose() {
    // _textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: const SafeArea(
          child: Column(
        children: [
          Text(
            'Welcome to Good Deads Salon',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          Padding(
            padding: EdgeInsets.all(25.0),
            child: TextField(
              maxLines: 1,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter PIN',
                  focusColor: Colors.greenAccent,
                  fillColor: Colors.green),
            ),
          ),
        ],
      )
          // Image.asset('lib/assets/google.png'),
          // SizedBox(
          //   width: 20,
          // ),
          //

          ),
    );
  }
}
