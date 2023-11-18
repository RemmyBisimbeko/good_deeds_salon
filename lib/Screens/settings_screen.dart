import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(const SettingsScreen());

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final userData = FirebaseAuth.instance.currentUser!;

  final TextEditingController username_Controller = TextEditingController();
  final TextEditingController telephone_Controller = TextEditingController();
  String documentId = '';

  String username = '';
  String initial_telephone = '';

  @override
  void initState() {
    super.initState();
    getUserDocID();
    fetchInitialValues();
  }

  Future<void> getUserDocID() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userData.email.toString().trim())
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        // Access the specific field's value from the document
        var docidFieldValue = document.id; //
        var usernameFieldValue = document.get('username');
        // var docID_field_value = document.get('username'); //
        setState(() {
          documentId = docidFieldValue
              .toString(); // Update the state with the field's value
          print('$documentId is the Doc ID of currently logged in user!');
          username = usernameFieldValue.toString();
        });
      } else {
        setState(() {
          documentId = userData.email
              .toString(); // Handle the case where no matching document is found
        });
      }
    } catch (error) {
      print(
          'Error fetching doc ID: $error'); // Handle the error and update the state
    }
  }

  Future<void> fetchInitialValues() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        // var username_field = documentSnapshot.get('username');
        var telephoneField = documentSnapshot.get('telephone');
        setState(() {
          initial_telephone = telephoneField.toString();
        });
      }
    } catch (error) {
      print('Error fetching initial values: $error');
    }
  }

  Future<void> updateDocument(String newUsername, String newTelephone) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update({
        'username': newUsername, // Replace 'field1' with the first field name
        'telephone':
            newTelephone, // Replace 'field2' with the second field name
      });
      print('Document updated successfully');
      // print('Ticked!');
      const snackBar = SnackBar(
          content: Text('Your details have been updated Successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print('Error updating document: $error');
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    username_Controller.dispose();
    telephone_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'lib/memes/profile.png',
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Text(
                username.toString(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(userData.email.toString()),
              const SizedBox(
                height: 50,
              ),

              // Username Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: username_Controller,
                  decoration: InputDecoration(
                    hintText: 'New Username',
                    // labelText: 'Username',
                    fillColor: Colors.grey[200],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Telephone Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: telephone_Controller,
                  decoration: InputDecoration(
                    hintText: 'New Telephone',
                    // labelText: 'Telephone',
                    fillColor: Colors.grey[200],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    String newUsername = username_Controller.text;
                    String newTelephone = telephone_Controller.text;
                    updateDocument(newUsername, newTelephone);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
