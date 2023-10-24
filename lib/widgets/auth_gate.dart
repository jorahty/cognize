import 'package:flutter/material.dart';
import 'package:cognize/services/auth.dart';
import 'package:cognize/pages/auth/page.dart';
import 'package:cognize/pages/home/page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasData) {
          return const HomePage(); // show home page when authenticated
        } else {
          return const AuthPage(); // show auth page when unauthenticated
        }
      },
    );
  }
}
