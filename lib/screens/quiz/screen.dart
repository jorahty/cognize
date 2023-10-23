import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/models.dart';
import '../../services/firestore.dart';
import '../../widgets/common/progress_bar.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/pressable.dart';

class QuizState with ChangeNotifier {
  final PageController controller = PageController();

  Option? _selectedOption;
  double _quizProgress = 0;

  Option? get selectedOption => _selectedOption;
  double get quizProgress => _quizProgress;

  set selectedOption(Option? option) {
    _selectedOption = option;
    notifyListeners();
  }

  set quizProgress(double value) {
    _quizProgress = value;
    notifyListeners();
  }

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
              title: AnimatedProgressBar(value: state.quizProgress),
            ),
            body: Center(
              child: SizedBox(
                width: 700,
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: state.controller,
                  onPageChanged: (index) => state.quizProgress =
                      (index / (quiz.questions.length + 1)),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(quiz.description),
          ],
        ),
        Expanded(
          child: Center(
            child: Button(
              onPressed: state.nextPage,
              leading: const Icon(Icons.rocket_launch_rounded),
              label: const Text('Start Quiz!'),
            ),
          ),
        ),
      ],
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({super.key, required this.question});

  _showBottomSheet(BuildContext context, Option option, QuizState state) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black45,
          padding: const EdgeInsets.all(20),
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                option.correct ? 'Good Job!' : 'Wrong',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                option.detail,
                style: GoogleFonts.inter(
                  color: Colors.white54,
                ),
              ),
              Button(
                color: option.correct
                    ? const Color(0xff0D7650)
                    : const Color(0xFFF44336),
                onPressed: () {
                  if (option.correct) state.nextPage();
                  Navigator.pop(context);
                },
                label: Text(
                  option.correct ? 'Onward!' : 'Try Again',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<QuizState>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(question.text),
        ),
        SafeArea(
          child: Column(
            children: question.options.map(
              (option) {
                return Pressable(
                  onPressed: () {
                    state.selectedOption = option;
                    _showBottomSheet(context, option, state);
                  },
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      mouseCursor: SystemMouseCursors.click,
                      leading: state.selectedOption == option
                          ? const Icon(FontAwesomeIcons.circleDot)
                          : const Icon(FontAwesomeIcons.circle),
                      title: Text(option.value),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
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
    return Center(
      child: FilledButton.icon(
        icon: const Icon(
          FontAwesomeIcons.check,
          color: Colors.green,
        ),
        style: FilledButton.styleFrom(backgroundColor: Colors.black45),
        onPressed: () {
          FirestoreService().updateUserReport(quiz);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        label: const Text('Mark Complete!'),
      ),
    );
  }
}
