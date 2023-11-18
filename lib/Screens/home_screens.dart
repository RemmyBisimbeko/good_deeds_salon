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
      body: Center(
        child: const Text(
          'Home Screen',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
