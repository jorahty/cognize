import 'package:cognize/widgets/quiz/list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Center(
        child: SizedBox(
          width: 700,
          child: ListView(
            children: [
              Hero(
                tag: topic.img,
                child: Image.asset(
                  'assets/placeholder.png',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  topic.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
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
      ),
    );
  }
}
