import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/topic/card.dart';

class TopicGrid extends StatelessWidget {
  final List<Topic> topics;
  const TopicGrid({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 350,
      padding: EdgeInsets.fromLTRB(
          10, 10, 10, MediaQuery.of(context).size.height * 0.7),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: topics.map((topic) => TopicCard(topic: topic)).toList(),
    );
  }
}
