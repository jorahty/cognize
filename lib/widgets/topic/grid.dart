import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/topic/card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TopicGrid extends StatelessWidget {
  final List<Topic> topics;
  const TopicGrid({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    // filter topics based on search state

    return GridView.extent(
      maxCrossAxisExtent: 350,
      padding: EdgeInsets.fromLTRB(
          10, 10, 10, MediaQuery.of(context).size.height * 0.7),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: topics
          .map((topic) => TopicCard(topic: topic))
          .toList()
          .animate(interval: 80.ms)
          .slide(duration: 500.ms, curve: const Cubic(0.5, 0.5, 0.7, 1.5))
          .scaleXY(),
    );
  }
}
