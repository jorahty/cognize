import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/screens/topics/grid.dart';
import 'package:cognize/screens/topics/drawer.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) {
      return const _MobileLayout();
    } else {
      return const _DesktopLayout();
    }
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: _Content()),
        BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'Topics',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.boltLightning),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidCircleUser),
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
  const _DesktopLayout();

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
        const Expanded(child: _Content()),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Fetch topics
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(title: const Text('Cognize')),
            drawer: TopicsDrawer(topics: topics),
            body: TopicGrid(topics: topics),
          );
        }
      },
    );
  }
}
