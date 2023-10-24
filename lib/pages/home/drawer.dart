import 'package:cognize/widgets/topic/list.dart';
import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class HomeDrawer extends StatelessWidget {
  final List<Topic> topics;
  const HomeDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: TopicList(topics: topics),
    );
  }
}
