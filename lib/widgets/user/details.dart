import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cognize/services/auth.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/auth_gate.dart';
import 'package:cognize/widgets/common/button.dart';

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
