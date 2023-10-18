import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';

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
            return GridView.count(
              crossAxisCount: 2,
              children: topics.map((topic) => Text(topic.title)).toList(),
            );
          }
        },
      ),
    );
  }
}
