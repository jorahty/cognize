import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cognize/services/auth.dart';

import '../../widgets/common/button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 280,
            ),
            Button(
              onPressed: AuthService().googleSignIn,
              leading: SvgPicture.asset(
                'assets/google_logo.svg',
                width: 18,
                height: 18,
              ),
              label: const Text('Continue with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
