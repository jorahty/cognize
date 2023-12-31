import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
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
      final EmojiParser emojiParser = EmojiParser();

      return Container(
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(user.photoURL!),
                ),
                Positioned(
                  bottom: -5,
                  right: -5,
                  child: Builder(builder: (context) {
                    String emoji = '';
                    if (report.points > 75) {
                      emoji = '🥇';
                    } else if (report.points > 50) {
                      emoji = '🥈';
                    } else if (report.points > 25) {
                      emoji = '🥉';
                    }

                    return Text(
                      emoji,
                      style: TextStyle(fontSize: 25, fontFamily: 'System'),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(
              '${report.points}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 15),
            Text(
              'Total Points',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            Text(
              '${report.total}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Quizzes Completed',
              style: Theme.of(context).textTheme.labelLarge,
            ),
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


