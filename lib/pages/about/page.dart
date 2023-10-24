import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Cognize is a free quiz app that allows self learning through quizzes on multiple subjects on this platform.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                "It allows for users to learn from predefined quizzes or collaborate and learn from other peoples quizzes or self-created quizzes.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Text(
                "It allows for the ability to learn from any device with integrated support for Windows, IOS and Android devices.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
