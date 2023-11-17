import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> questions = List.generate(
    5,
    (index) => {
      'question': '',
      'options': ['', '', ''],
      'correctAnswer': '', // Initialize correctAnswer to the first option
    },
  );

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
              child: Column(
                children: [
                  ListTile(
                    title: Text('Question $questionNumber'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Question Text'),
                  ),
                  for (int i = 1; i <= 3; i++)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Option $i'),
                    ),
                  DropdownButton<String>(
                    value: questions[index]['correctAnswer'],
                    onChanged: (String? newValue) {
                      setState(() {
                        questions[index]['correctAnswer'] = newValue!;
                      });
                    },
                    items: questions[index]['options'].map<DropdownMenuItem<String>>(
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
            );
          },
        ),
      ),
    );
  }
}
