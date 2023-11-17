import 'package:flutter/material.dart';

import 'quiz_submit_page.dart';

class QuizQuestionsPage extends StatefulWidget {
  final String category;
  final String title;
  final int numQuestions;

  QuizQuestionsPage({
    required this.category,
    required this.title,
    required this.numQuestions,
  });

  @override
  _QuizQuestionsPageState createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  late List<Map<String, dynamic>> questions;
  late List<String?> selectedAnswers; // Track selected answers for each question

  @override
  void initState() {
    super.initState();

    questions = List.generate(
      widget.numQuestions,
      (index) => {
        'question': '',
        'options': ['', '', ''],
        'correctAnswer': '', // Initialize correctAnswer to an empty string
      },
    );

    selectedAnswers = List.generate(widget.numQuestions, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Quiz Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.numQuestions,
          itemBuilder: (context, index) {
            int questionNumber = index + 1;
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question $questionNumber',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Question Text',
                      ),
                      onChanged: (value) {
                        setState(() {
                          questions[index]['question'] = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    for (int i = 0; i < 3; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Option ${i + 1}',
                          ),
                          onChanged: (value) {
                            setState(() {
                              questions[index]['options'][i] = value;
                            });
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedAnswers[index],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAnswers[index] = newValue;
                          questions[index]['correctAnswer'] = newValue!;
                        });
                      },
                      items: (questions[index]['options'] as List<String>? ?? [])
                          .where((value) => value != null)
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>(
                        (value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle the submission of questions
            // You can save the 'questions' array here
            print(questions);

            // Show the confirmation page without delay
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => QuizSubmissionPage(),
              ),
            );
          },
          child: Text('Submit'),
        ),
      ),
    );
  }
}
