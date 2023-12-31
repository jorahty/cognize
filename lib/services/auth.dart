import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This service is responsible for interacting with the Firestore Auth

class AuthService {
  final authStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
