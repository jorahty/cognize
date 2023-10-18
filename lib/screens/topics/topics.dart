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
            return GridView.extent(
              maxCrossAxisExtent: 350,
              children: topics.map((topic) => TopicCard(topic: topic)).toList(),
            );
          }
        },
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            topic.title,
            style: Theme.of(context).textTheme.titleMedium,
            // overflow: TextOverflow.fade,
            // softWrap: false,
          ),
        ],
      ),
    );
  }
}
