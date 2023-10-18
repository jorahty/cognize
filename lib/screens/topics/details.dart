import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cognize/services/models.dart';

class TopicDetails extends StatelessWidget {
  final Topic topic;

  const TopicDetails({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 900) {
                return Image.asset(
                  'assets/placeholder.png',
                  width: MediaQuery.of(context).size.width,
                );
              } else {
                return Container();
              }
            },
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
        ],
      ),
    );
  }
}
