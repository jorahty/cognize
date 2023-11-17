import 'package:flutter/material.dart';
import 'quiz_questions_page.dart';

class QuizSettingsPage extends StatefulWidget {
  @override
  _QuizSettingsPageState createState() => _QuizSettingsPageState();
}

class _QuizSettingsPageState extends State<QuizSettingsPage> {
  String selectedCategory = "General Knowledge";
  int numberOfQuestions = 5;
  String quizTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue ?? "General Knowledge";
                });
              },
              items: <String>[
                "General Knowledge",
                "Science",
                "History",
                "Math",
                "Programming",
                "Sports",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Quiz Title'),
              onChanged: (value) {
                setState(() {
                  quizTitle = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Number of Questions'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = int.tryParse(value) ?? 0;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizQuestionsPage(
                      category: selectedCategory,
                      title: quizTitle,
                      numQuestions: numberOfQuestions,
                    ),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
