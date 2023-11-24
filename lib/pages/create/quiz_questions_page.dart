import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'quiz_submit_page.dart';

class QuizQuestionsPage extends StatefulWidget {
  final String category;
  final String title;
  final int numQuestions;
  final String description;

  QuizQuestionsPage({
    required this.category,
    required this.title,
    required this.numQuestions,
    required this.description,
  });

  @override
  _QuizQuestionsPageState createState() => _QuizQuestionsPageState();
}

String convertToSlug(String input) {
  return input.toLowerCase().replaceAll(' ', '-');
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  late Quiz userCreatedQuiz;

  @override
  void initState() {
    super.initState();

    userCreatedQuiz = Quiz(
      id: convertToSlug(widget.title),
      title: widget.title,
      topic: widget.category,
      description: widget.description,
      video: 'Default Video URL',
      questions: List.generate(widget.numQuestions, (index) {
        return Question(
          text: '',
          options: List.generate(
              3, (i) => Option(value: '', detail: '', correct: false)),
        );
      }),
    );
  }

  Future<void> submitQuizToFirestore() async {
    try {
      // Submit quiz to Firestore
      await FirestoreService().submitQuiz(userCreatedQuiz);

      // Fetch the topic by category
      Topic? topic =
          await FirestoreService().getTopicByCategory(widget.category);

      if (topic != null) {
        // Add the new quiz to the topic
        topic.quizzes.add(userCreatedQuiz);

        // Update the topic in Firestore
        await FirestoreService().updateTopicWithQuiz(topic, userCreatedQuiz);

        print('Quiz submitted to Firestore and added to the topic!');
      } else {
        print('Topic not found!');
      }
    } catch (error) {
      print('Error submitting quiz to Firestore: $error');
    }
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
                          userCreatedQuiz.questions[index].text = value;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    for (int i = 0; i < 3; i++) ...[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Option ${i + 1} Text',
                        ),
                        onChanged: (value) {
                          setState(() {
                            userCreatedQuiz.questions[index].options[i].value =
                                value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Option ${i + 1} Description',
                        ),
                        onChanged: (value) {
                          setState(() {
                            userCreatedQuiz.questions[index].options[i].detail =
                                value;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      Checkbox(
                        value:
                            userCreatedQuiz.questions[index].options[i].correct,
                        onChanged: (value) {
                          setState(() {
                            userCreatedQuiz.questions[index].options[i]
                                .correct = value ?? false;
                          });
                        },
                      ),
                    ],
                    SizedBox(height: 16),
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
            submitQuizToFirestore();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuizSubmissionPage(userCreatedQuiz: userCreatedQuiz),
              ),
            );
          },
          child: Text('Submit Quiz'),
        ),
      ),
    );
  }
}
