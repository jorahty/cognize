import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_submit_page.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';

import 'dart:convert';

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
  late Quiz userCreatedQuiz;
  List<List<Option>> optionValues = [];
  late String selectedTopicId; // New variable to store selected topic ID

  @override
  void initState() {
    super.initState();
    selectedTopicId = ''; // Initialize the selectedTopicId

    userCreatedQuiz = Quiz(
      id: FirebaseFirestore.instance.collection('quizzes').doc().id,
      title: widget.title,
      topic: selectedTopicId, // Set topic to selectedTopicId
      description: 'Default Description',
      questions: List.generate(widget.numQuestions, (index) {
        optionValues.add(List.generate(3, (i) => Option(value: '', detail: '', correct: false)));
        return Question(
          text: '',
          options: List.generate(3, (i) => Option(value: '', detail: '', correct: false)),
        );
      }),
    );
  }

  void submitTopicToFirestore(Topic topic) async {
    try {
      // Convert Topic to Map
      Map<String, dynamic> topicData = topic.toMap();

      // Submit Topic to Firestore
      await FirebaseFirestore.instance
          .collection('topics')
          .doc(topic.id)
          .set(topicData);

      print('Topic submitted to Firestore!');
    } catch (error) {
      print('Error submitting topic to Firestore: $error');
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
                    SizedBox(height: 16),
                    
                    for (int i = 0; i < 3; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Option ${i + 1} Value',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  optionValues[index][i].value = value;
                                });
                              },
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Option ${i + 1} Detail (Optional)',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  optionValues[index][i].detail = value;
                                });
                              },
                            ),
                            SizedBox(height: 8),
                            Checkbox(
                              value: optionValues[index][i].correct,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  optionValues[index][i].correct = newValue ?? false;
                                });
                              },
                            ),
                          ],
                        ),
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
          onPressed: () async {
            // Fetch existing topics
            List<Topic> existingTopics = await FirestoreService().getTopics();

            // Find the selected topic
            Topic? existingTopic = existingTopics.firstWhere(
              (topic) => topic.id == selectedTopicId,
              orElse: () => null,
            );

            if (existingTopic == null) {
              print('Selected topic not found in existing topics.');
              return;
            }

            // Update quizzes in the selected topic
            List<Quiz> quizList = existingTopic.quizzes;
            quizList.add(userCreatedQuiz);
            existingTopic.quizzes = quizList;

            // Submit the updated topic to Firestore
            submitTopicToFirestore(existingTopic);

            // Navigate to the next page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizSubmissionPage(userCreatedQuiz: userCreatedQuiz),
              ),
            );
          },
          child: Text('Next'),
        ),
      ),
    );
  }
}
