import 'package:cognize/widgets/common/pressable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/widgets/topic/details.dart';
import 'package:cognize/widgets/common/progress_bar.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard({super.key, required this.topic});

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
                child: TopicDetails(topic: topic),
              );
            },
          ),
        );
      },
      child: Hero(
        tag: topic.img,
        child: Card(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/topics/${topic.img}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        TopicProgress(topic: topic),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: AnimatedProgressBar(
            value: _calculateProgress(topic, report),
            height: 8,
          ),
        ),
      ],
    );
  }

  double _calculateProgress(Topic topic, Report report) {
    try {
      int totalQuizzes = topic.quizzes.length;
      int completedQuizzes = report.topics[topic.id].length;
      return completedQuizzes / totalQuizzes;
    } catch (err) {
      return 0.0;
    }
  }
}
