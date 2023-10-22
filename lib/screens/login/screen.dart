import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cognize/services/auth.dart';

import '../../widgets/common/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Button(
          onPressed: AuthService().googleSignIn,
          color: const Color(0xFF444444),
          leading: SvgPicture.asset(
            'assets/google_logo.svg',
            width: 18,
            height: 18,
          ),
          label: const Text('Continue with Google'),
        ),
      ),
    );
  }
}
