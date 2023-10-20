import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/services/models.dart';

class QuizState with ChangeNotifier {
  final PageController controller = PageController();

  nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
    );
  }
}

class QuizScreen extends StatelessWidget {
  final String quizId;
  const QuizScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final quiz = snapshot.data!;
          final state = Provider.of<QuizState>(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black45,
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => Navigator.pop(context),
                tooltip: 'Exit quiz',
              ),
            ),
            body: PageView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              controller: state.controller,
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
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('StartPage: ${quiz.title}'),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: state.nextPage,
          child: const Text('Start Quiz!'),
        ),
      ],
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('QuestionPage: ${question.text}'),
        Column(
          children: question.options.map(
            (opt) {
              return Card(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(opt.value),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        FilledButton(
          onPressed: state.nextPage,
          child: const Text('Onward!'),
        ),
      ],
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('CongratsPage: ${quiz.title}'),
        FilledButton.icon(
          icon: const Icon(
            FontAwesomeIcons.check,
            color: Colors.green,
          ),
          style: FilledButton.styleFrom(backgroundColor: Colors.black45),
          onPressed: () {
            // todo: update user report in firestore
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          label: const Text('Mark Complete!'),
        ),
      ],
    );
  }
}
