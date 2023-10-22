import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/widgets/topic/grid.dart';
import 'package:cognize/screens/topics/drawer.dart';
import 'package:cognize/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user!;

    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Fetch topics
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cognize'),
              leading: Row(
                children: [
                  Builder (
                    builder: (BuildContext context) => IconButton(
                      icon: const Icon(FontAwesomeIcons.bars),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )
                  ),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(user.photoURL!),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text(
                        user.displayName!,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            drawer: TopicsDrawer(topics: topics),
            body: _Body(topics: topics),
          );
        }
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) {
      return _MobileLayout(topics: topics);
    } else {
      return _DesktopLayout(topics: topics);
    }
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TopicGrid(topics: topics)),
        BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house, size: 18),
              label: 'Topics',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.boltLightning, size: 18),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidCircleUser, size: 18),
              label: 'Profile',
            ),
          ],
          onTap: (value) {
            if (value == 1) {
              Navigator.pushNamed(context, '/about');
            } else if (value == 2) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavigationRail(
          labelType: NavigationRailLabelType.all,
          selectedIndex: 0,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(FontAwesomeIcons.house),
              label: Text('Topics'),
            ),
            NavigationRailDestination(
              icon: Icon(FontAwesomeIcons.boltLightning),
              label: Text('About'),
            ),
            NavigationRailDestination(
              icon: Icon(FontAwesomeIcons.solidCircleUser),
              label: Text('Profile'),
            ),
          ],
          onDestinationSelected: (value) {
            if (value == 1) {
              Navigator.pushNamed(context, '/about');
            } else if (value == 2) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
        Expanded(child: TopicGrid(topics: topics)),
      ],
    );
  }
}
