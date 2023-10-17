import 'package:cognize/services/auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: AuthService().googleSignIn,
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
