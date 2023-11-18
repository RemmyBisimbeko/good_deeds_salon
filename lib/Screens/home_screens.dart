import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Good Deeds Salon',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) {
                    return ServicesScreen(
                      current_username: '',
                    );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) {
                    return ServicesScreen(current_username: 'current_username');
                  },
                ),
              );
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // color: Colors.purple[200],
              width: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [
                  Icon(Icons.home_outlined),
                  Text('Home'),
                  SizedBox(
                    height: 30,
                  ),
                  Icon(Icons.dashboard_outlined),
                  Text('Dashboard'),
                  SizedBox(
                    height: 550,
                  ),
                  Divider(
                    color: Colors.deepPurple,
                    thickness: 0.5, // Adjust the thickness as needed
                  ),
                  Icon(Icons.logout_outlined),
                  Text('Log Out'),
                ]),
              ),
            ),
            VerticalDivider(), // Divider between sections
            Expanded(
              child: Center(
                child: const Text(
                  'Home Screen',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            VerticalDivider(), // Divider between sections
            Container(
              color: Colors.amber[200],
              width: 300,
              child: Text('Process Order Pane'),
            ),
          ],
        ),
      ),
    );
  }
}
