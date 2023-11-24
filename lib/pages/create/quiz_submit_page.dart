import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import '../../widgets/common/button.dart';

class QuizSubmissionPage extends StatelessWidget {
  final Quiz userCreatedQuiz;

  QuizSubmissionPage({required this.userCreatedQuiz});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Allow back navigation only when the user explicitly presses the back button
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Submitted'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80.0,
              ),
              SizedBox(height: 16),
              Text(
                'Quiz Submitted Successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
