import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class TopicsDrawer extends StatelessWidget {
  final List<Topic> topics;
  const TopicsDrawer({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
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
                child: Text(topic.title),
              ),
              QuizList(topic: topic),
            ],
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map(
        (quiz) {
          return Card(
            elevation: 0,
            child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(quiz.title),
                subtitle: Text(
                  quiz.description,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
