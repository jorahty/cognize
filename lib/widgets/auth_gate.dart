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
          return const HomePage(); // When logged in, show topics screen
        } else {
          return const AuthPage(); // When logged out, show login screen
        }
      },
    );
  }
}
