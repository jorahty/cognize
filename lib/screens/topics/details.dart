import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/screens/topics/drawer.dart';

class TopicDetails extends StatelessWidget {
  final Topic topic;

  const TopicDetails({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                padding: const EdgeInsets.all(8.0),
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
              QuizList(topic: topic),
            ],
          ),
        ),
      ),
    );
  }
}
