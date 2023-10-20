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
            body: Center(
              child: SizedBox(
                width: 700,
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: state.controller,
                  itemCount: quiz.questions.length + 2,
                  itemBuilder: (context, index) {
                    late final Widget page;

                    if (index == 0) {
                      page = StartPage(quiz: quiz);
                    } else if (index <= quiz.questions.length) {
                      page = QuestionPage(question: quiz.questions[index - 1]);
                    } else {
                      page = CongratsPage(quiz: quiz);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: page,
                    );
                  },
                ),
              ),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(quiz.description),
            ],
          ),
        ),
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
        Expanded(
          child: Text(question.text),
        ),
        Column(
          children: question.options.map(
            (option) {
              return Card(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.circle),
                    title: Text(option.value),
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
