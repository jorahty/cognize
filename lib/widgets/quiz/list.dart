import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/quiz/card.dart';
import 'package:flutter/material.dart';

class QuizList extends StatelessWidget {
  final Topic topic;
  const QuizList({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes.map((quiz) => QuizCard(quiz: quiz)).toList(),
    );
  }
}
