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
              itemCount: quiz.questions.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StartPage(quiz: quiz);
                } else if (index <= quiz.questions.length) {
                  return QuestionPage(question: quiz.questions[index - 1]);
                } else {
                  return CongratsPage(quiz: quiz);
                }
              },
            ),
          );
        }
      },
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('StartPage: ${quiz.title}'));
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('CongratsPage: ${quiz.title}'));
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('QuestionPage: ${question.text}'));
  }
}
