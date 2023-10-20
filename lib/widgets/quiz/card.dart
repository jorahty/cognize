import 'package:cognize/screens/quiz/screen.dart';
import 'package:cognize/services/models.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final Quiz quiz;
  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const QuizScreen(),
            ),
          );
        },
        child: ListTile(
          title: Text(quiz.title),
          subtitle: Text(
            quiz.description,
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
