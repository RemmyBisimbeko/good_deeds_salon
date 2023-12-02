import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/profiles_screen.dart';
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
                    return const ProfileScreen(
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
                    return const ServicesScreen();
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
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
                    thickness: 0.2, // Adjust the thickness as needed
                  ),
                  Icon(Icons.logout_outlined),
                  Text('Log Out'),
                ]),
              ),
            ),
            const VerticalDivider(), // Divider between sections
            const Expanded(
              child: Center(
                // child: const Text(
                //   'Home Screen',
                //   style: TextStyle(fontSize: 50),
                // ),
                child: ServicesScreen(),
              ),
            ),
            const VerticalDivider(), // Divider between sections

            Container(
              color: Colors.purple[200],
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Order',
                    style: TextStyle(fontSize: 40),
                  ),
                  const Text(
                    'Sub Total',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                  ),
                  // List.builder(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Check out',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
