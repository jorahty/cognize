import 'package:cognize/services/models.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;
  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(quiz.title),
          subtitle: Text(quiz.description),
        ),
      ),
    );
  }
}
