import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In

  signInWithGoogle() async {
    // Initiate Sign in Process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Finally, lets sign in the user
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
