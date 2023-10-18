import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/screens/topics/grid.dart';

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
        fixedColor: const Color(0xff00CD77),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Topics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
