import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/screens/quiz/screen.dart';
import 'package:cognize/services/models.dart';

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
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: QuizScreen(quizId: quiz.id),
                );
              },
            ),
          );
        },
        child: ListTile(
          leading: QuizBadge(quiz: quiz),
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

class QuizBadge extends StatelessWidget {
  final Quiz quiz;
  const QuizBadge({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 40,
      height: 40,
      child: Icon(
        FontAwesomeIcons.solidCircleCheck,
        color: Colors.green,
      ),
    );
  }
}
