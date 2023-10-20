import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user!;
    final report = Provider.of<Report>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(
        padding: const EdgeInsets.all(30),
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
            Text(
              '${report.total}',
              style: GoogleFonts.inter(
                fontSize: 56,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Quizzes Completed',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: Colors.white60,
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
