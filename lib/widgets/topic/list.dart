import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/quiz/list.dart';
import 'package:flutter/material.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key, required this.topics});

  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: topics.length,
        itemBuilder: (context, index) {
          Topic topic = topics[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  topic.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              QuizList(topic: topic),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
