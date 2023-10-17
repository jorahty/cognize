import 'package:cognize/services/auth.dart';
import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: AuthService().signOut,
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
