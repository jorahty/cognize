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
          final quiz = snapshot.data!;

          return Scaffold(
            appBar: AppBar(),
            body: PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const StartPage();
              },
            ),
          );
        }
      },
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
