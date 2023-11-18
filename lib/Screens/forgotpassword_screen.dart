import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotpasswordState createState() => ForgotpasswordState();
}

class ForgotpasswordState extends State<ForgotpasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      // Display Success message
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
                'Password rest link has been Successfully sent! Please check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      // Display Error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 200),
            child: Text(
              'Enter your email and we send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // Email text Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
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

          // MaterialButton(
          //   onPressed: () {},
          //   color: Colors.deepPurple,
          //   padding: const EdgeInsets.symmetric(horizontal: 200),
          //   child: Text(
          //     'Rest Password',
          //     style:
          //         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //   ),
          // ),

          // Login Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: const Size.fromHeight(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: passwordRest,
              child: const Text(
                'Reset Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
