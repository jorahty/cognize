import 'package:cognize/widgets/quiz/list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';

class TopicDetails extends StatelessWidget {
  final Topic topic;

  const TopicDetails({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Hero(
                      tag: topic.img,
                      child: Image.asset(
                        'assets/topics/${topic.img}',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        topic.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: QuizList(topic: topic),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 2),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*
[
  Hero(
    tag: topic.img,
    child: Image.asset(
      'assets/topics/${topic.img}',
      width: MediaQuery.of(context).size.width,
    ),
  ),
  Padding(
    padding: const EdgeInsets.all(20),
    child: Text(
      topic.title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
  ),
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: QuizList(topic: topic),
  ),
  SizedBox(height: MediaQuery.of(context).size.height / 2),
]
*/
