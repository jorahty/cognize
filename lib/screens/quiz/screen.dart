import 'package:cognize/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quiz>(
      future: FirestoreService().getQuiz(quizId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final quiz = snapshot.data ?? Quiz();

          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(quiz.title)),
          );
        }
      },
    );
  }
}
