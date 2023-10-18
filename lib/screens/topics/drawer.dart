import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class TopicsDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicsDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: topics.length,
        itemBuilder: (context, index) {
          Topic topic = topics[index];
          return Text(topic.title);
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
