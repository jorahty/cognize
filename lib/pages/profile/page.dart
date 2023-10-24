import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/auth.dart';
import '../../services/models.dart';
import '../../widgets/common/button.dart';
import '../../widgets/auth_gate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Profile'),
      ),
      body: const UserDetails(),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user;
    final report = Provider.of<Report>(context);

    if (user == null) {
      return const SizedBox.shrink();
    } else {
      return Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(user.photoURL!),
            ),
            Text(user.displayName!),
            const Spacer(),
            Text('${report.total}'),
            const Text('Quizzes Completed'),
            const Spacer(),
            Button(
              onPressed: () async {
                await AuthService().signOut().then((_) {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const AuthGate();
                      },
                      transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return child; // No transition, just return the child
                      },
                    ),
                    (route) => false,
                  );
                });
              },
              leading: const Icon(FontAwesomeIcons.arrowRightFromBracket),
              label: const Text('Logout'),
            ),
            const Spacer(),
          ],
        ),
      );
    }
  }
}
