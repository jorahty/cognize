import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class TopicsDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicsDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return const Text('Hello, Drawer');
  }
}
