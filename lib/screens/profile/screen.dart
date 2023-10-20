import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user!;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(user.photoURL!),
            ),
            Text(
              user.displayName!,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 2,
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
              label: const Text('Logout'),
              onPressed: () {
                AuthService().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
