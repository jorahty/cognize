import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/screens/topics/grid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cognize')),
      body: const TopicsScreenBody(),
    );
  }
}

class TopicsScreenBody extends StatelessWidget {
  const TopicsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mainArea = FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Fetch topics
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        } else {
          final topics = snapshot.data!;
          return TopicGrid(topics: topics);
        }
      },
    );

    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) {
      return Column(
        children: [
          Expanded(child: mainArea),
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
          ),
        ],
      );
    } else {
      return Row(
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
          ),
          Expanded(child: mainArea),
        ],
      );
    }
  }
}
