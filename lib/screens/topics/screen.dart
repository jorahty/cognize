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
      appBar: AppBar(title: const Text('Topics')),
      body: FutureBuilder<List<Topic>>(
        future: FirestoreService().getTopics(), // Fetch topics
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else {
            final topics = snapshot.data!;
            return TopicGrid(topics: topics);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
