import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:good_deeds_salon/Screens/login_screen.dart';
import 'package:good_deeds_salon/Screens/login_screen.dart';
import 'package:good_deeds_salon/Screens/settings_screen.dart';
import 'package:share_plus/share_plus.dart';

// void main() => runApp(ServicesScreen());

class ProfileScreen extends StatefulWidget {
  // Args
  final String current_username;

  const ProfileScreen({Key? key, required this.current_username})
      : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  final userData = FirebaseAuth.instance.currentUser!;

  Stream<QuerySnapshot<Map<String, dynamic>>> getMemesStream() {
    return FirebaseFirestore.instance
        .collection('memes')
        // .where('username', isEqualTo: 'sunflower')
        .where('username',
            isEqualTo: userData.email.toString().replaceAll('@', ''))
        .snapshots();
  }

  void screenshotMeme(BuildContext context) {
    const snackBar =
        SnackBar(content: Text('Screenshots will be coming soon!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void downloadMeme(BuildContext context) {
    const snackBar =
        SnackBar(content: Text('Meme has been downloaded successfully!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: Text('Settings'),
                ),
                value: 'Settings',
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  ),
                  title: Text('Log Out'),
                ),
                value: 'Log Out',
              ),
            ],
            onSelected: (value) {
              if (value == 'Settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              } else if (value == 'Log Out') {
                signOut();
              }
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getMemesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.deepPurple[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.deepPurpleAccent),
                ),
              ),
            ); // Display a loading indicator while data is loading
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('Looks like you have you don\'t have an yet!'));
          }

          return DynamicHeightGridView(
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 3,
              builder: (context, index) {
                var document = snapshot.data!.docs[index];
                // Access document data using document.data()
                var data = document.data();

                // Create widgets to display the document data
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (builder) {
                                //       return const DetailMemeScreen(
                                //           current_username: current_username);
                                //     },
                                //   ),
                                // );
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12), // Image border
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(50), // Image radius
                                  child: Image.network(data['image'],
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              });
        },
      ),
    );
  }
}
