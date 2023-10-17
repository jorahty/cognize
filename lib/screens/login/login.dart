import 'package:cognize/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff222222)),
          ),
          onPressed: AuthService().googleSignIn,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/google_logo.svg', // Replace with the path to your SVG image
                width: 18, // Set the width of the SVG image
                height: 18, // Set the height of the SVG image
              ),
              const SizedBox(width: 10),
              const Text('Continue with Google'),
            ],
          ),
        ),
      ),
    );
  }
}
