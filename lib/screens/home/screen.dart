import 'package:flutter/material.dart';
import 'package:cognize/services/auth.dart';
import 'package:cognize/screens/login/login.dart';
import 'package:cognize/screens/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasData) {
          return const TopicsScreen(); // When logged in, show topics screen
        } else {
          return const LoginScreen(); // When logged out, show login screen
        }
      },
    );
  }
}
