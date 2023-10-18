import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/screens/topics/card.dart';

class TopicGrid extends StatelessWidget {
  final List<Topic> topics;
  const TopicGrid({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 350,
      padding: const EdgeInsets.all(10),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: topics.map((topic) => TopicCard(topic: topic)).toList(),
    );
  }
}
