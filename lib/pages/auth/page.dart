import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cognize/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/common/button.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2),
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cuckoo',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 280,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A platform where users can evaluate their knowledge and skills.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Cuckoo',
                ),
              ),
              const SizedBox(height: 30),
              Button(
                onPressed: AuthService().googleSignIn,
                leading: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/google_logo.svg',
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                label: const Text('Login with Google'),
              ),
              const SizedBox(height: 15),
              Button(
                onPressed: () {
                  launchUrl(Uri.parse('https://cognize.dev/slides.pdf'));
                },
                leading: const Icon(FontAwesomeIcons.circleInfo),
                label: const Text('Learn More'),
              ),
              const SizedBox(height: 15),
              Button(
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/jorahty/cognize'));
                },
                leading: const Icon(FontAwesomeIcons.github),
                label: const Text('GitHub Repository'),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
