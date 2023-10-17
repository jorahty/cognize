import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final authStream = FirebaseAuth.instance.authStateChanges();
}
