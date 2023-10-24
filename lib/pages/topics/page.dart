import 'package:flutter/material.dart';

import '../../services/models.dart';
import '../../widgets/topic/grid.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key, required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return TopicGrid(topics: topics);
  }
}
