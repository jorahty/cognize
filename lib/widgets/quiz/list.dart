import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/quiz/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizList extends StatelessWidget {
  const QuizList({super.key, required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: topic.quizzes
          .map((quiz) => QuizCard(topic: topic, quiz: quiz))
          .toList()
          .animate(interval: 80.ms)
          .slide(duration: 400.ms, curve: const Cubic(0.5, 0.5, 0.7, 1.2))
          .scaleXY(),
    );
  }
}
