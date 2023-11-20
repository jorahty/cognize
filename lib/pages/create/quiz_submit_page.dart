import 'dart:async';
import 'package:flutter/material.dart';

class QuizSubmissionPage extends StatelessWidget {
  final Quiz userCreatedQuiz;

  QuizSubmissionPage({required this.userCreatedQuiz}) {
    _sendQuizToDatabase(userCreatedQuiz); // Call the function to send the quiz to the database
  }

  Future<void> _sendQuizToDatabase(Quiz quiz) async {
    try {
      await FirestoreService().addQuiz(quiz);
      print('Quiz submitted successfully!');
    } catch (e) {
      print('Error submitting quiz: $e');
      // Handle the error appropriately.
    }
  }

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
