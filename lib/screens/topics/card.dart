import 'package:cognize/services/models.dart';
import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            topic.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            // overflow: TextOverflow.fade,
            // softWrap: false,
          ),
        ],
      ),
    );
  }
}
