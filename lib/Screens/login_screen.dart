import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/forgotpassword_screen.dart';
import 'package:good_deeds_salon/Screens/services_screen.dart';
import 'package:good_deeds_salon/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback revealSignupScreen;
  const LoginScreen({Key? key, required this.revealSignupScreen})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final FocusNode _textFocus = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future appLogin() async {
    // Spinner
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      final snackBar = SnackBar(content: Text('Looks like ${e.message}'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // Dismiss the Spinner
    Navigator.pop(context);
  }

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
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_2_outlined,
                  size: 100,
                ),
                const SizedBox(
                  height: 40,
                ),

                // Greeting
                const Text(
                  'Good Deeds',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Welcome to Good Deeds Salon',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                // Email Text Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
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

                // Password Text Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[400],
                      minimumSize: const Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: appLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.deepPurple,
                          thickness: 1, // Adjust the thickness as needed
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 200.0),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.deepPurple,
                          thickness: 1, // Adjust the thickness as needed
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple[300],
                      minimumSize: const Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => AuthService().signInWithGoogle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/google.png',
                          width: 40.0,
                          height: 40.0,
                          // color: Colors.deepPurple,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) {
                              return const ForgotpasswordScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                // Sign up Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    GestureDetector(
                      onTap: widget.revealSignupScreen,
                      child: const Text(
                        ' Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
