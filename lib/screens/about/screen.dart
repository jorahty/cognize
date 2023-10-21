import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key); // fixed key initialization

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
        // Added Center widget to center its children
        child: Padding(
          // Added Padding for some spacing
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Cognize is an app that allows you to take quizzes with ease, it's the next quizlet!",
            textAlign: TextAlign.center, // To align text to center
            style: TextStyle(
              // Optional: for styling your text
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
