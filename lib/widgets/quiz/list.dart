import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/quiz/card.dart';
import 'package:flutter/material.dart';

class QuizList extends StatelessWidget {
  final List<Quiz> quizzes;
  const QuizList({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: quizzes.map((quiz) => QuizCard(quiz: quiz)).toList(),
    );
  }
}
