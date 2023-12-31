import 'package:cognize/pages/quiz/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/models.dart';
import '../../services/firestore.dart';
import '../../widgets/common/progress_bar.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/pressable.dart';

class QuizPage extends StatelessWidget {
  final String quizId;
  const QuizPage({super.key, required this.quizId});

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

    final platform = Theme.of(context).platform;

    final onMobile =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;

    final onMobileWeb = onMobile && kIsWeb;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              quiz.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: RepaintBoundary(
              child: Button(
                onPressed: state.nextPage,
                leading: const Icon(Icons.rocket_launch_rounded),
                label: const Text('Start Quiz!'),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .slideY(
                    end: 0.15,
                    duration: 1.seconds,
                    curve: const Cubic(1, 0, 0.7, 1),
                  )
                  .addEffect(
                    onMobileWeb
                        ? const Effect()
                        : const TintEffect(
                            color: Color(0x3462DAFF),
                          ),
                  ),
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
          color: Theme.of(context).colorScheme.surfaceVariant,
          padding: const EdgeInsets.all(20),
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                option.correct ? 'Good Job!' : 'Wrong',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                option.detail,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Button(
                onPressed: () {
                  if (option.correct) state.nextPage();
                  Navigator.pop(context);
                },
                color: option.correct
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.error,
                label: Text(option.correct ? 'Onward!' : 'Try Again'),
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
          child: Text(
            question.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
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
    final platform = Theme.of(context).platform;

    final onMobile =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;

    final onMobileWeb = onMobile && kIsWeb;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You completed the ${quiz.title} quiz',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset('assets/wolf.gif'),
          ),
          const SizedBox(height: 20),
          RepaintBoundary(
            child: Button(
              onPressed: () {
                FirestoreService().updateUserReport(quiz);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              leading: const Icon(FontAwesomeIcons.circleCheck),
              label: const Text('Mark Complete'),
              color: Theme.of(context).colorScheme.secondary,
            )
                .animate(onPlay: (controller) => controller.repeat())
                .addEffect(
                  onMobileWeb
                      ? const Effect()
                      : ShimmerEffect(
                          delay: 400.ms,
                          duration: 1800.ms,
                          color: Colors.white30,
                        ),
                )
                .shake(hz: 1, curve: Curves.easeInOutCubic, rotation: 0.05)
                .scaleXY(end: 1.1, duration: 600.ms)
                .then(delay: 600.ms)
                .scaleXY(end: 1 / 1.1, curve: Curves.easeOut)
                .then(delay: 0.1.seconds),
          ),
        ],
      ),
    );
  }
}
