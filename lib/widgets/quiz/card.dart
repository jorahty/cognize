import 'package:cognize/widgets/common/pressable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/pages/quiz/page.dart';
import 'package:cognize/services/models.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.topic, required this.quiz});
  final Topic topic;
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: QuizPage(quizId: quiz.id),
              );
            },
          ),
        );
      },
      child: Card(
        child: ListTile(
          mouseCursor: SystemMouseCursors.click,
          leading: QuizBadge(topicId: topic.id, quizId: quiz.id),
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
  const QuizBadge({super.key, required this.topicId, required this.quizId});
  final String topicId;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topicId] ?? [];

    final icon = completed.contains(quizId)
        ? const Icon(FontAwesomeIcons.solidCircleCheck, color: Colors.green)
        : const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);

    return SizedBox(width: 40, height: 40, child: icon);
  }
}
