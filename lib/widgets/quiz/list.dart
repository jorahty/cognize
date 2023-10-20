import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/quiz/card.dart';
import 'package:flutter/material.dart';

class QuizList extends StatelessWidget {
  const QuizList({super.key, required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes
          .map((quiz) => QuizCard(topic: topic, quiz: quiz))
          .toList(),
    );
  }
}
