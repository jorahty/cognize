import 'package:flutter/material.dart';
import 'quiz_questions_page.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/services/models.dart';

class QuizSettingsPage extends StatefulWidget {
  @override
  _QuizSettingsPageState createState() => _QuizSettingsPageState();
}

class _QuizSettingsPageState extends State<QuizSettingsPage> {
  late Future<List<Topic>> topicsFuture;
  Topic? selectedCategory; // Change the type to Topic
  int numberOfQuestions = 5;
  String quizTitle = "random";
  String quizDescription = "describe quiz";

  @override
  void initState() {
    super.initState();
    topicsFuture = FirestoreService().getTopics();
    // Set an initial value for selectedCategory based on your requirements
    // For example, you can set it to the first topic in the list.
    // Make sure to handle the case where the list is empty.
    selectedCategory = null;
    _loadTopics(); // Call a function to load topics
  }

  Future<void> _loadTopics() async {
    List<Topic> topics = await topicsFuture;
    if (topics.isNotEmpty) {
      setState(() {
        selectedCategory = topics[0]; // Set to the first topic
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Topic>>(
          future: topicsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No topics available'));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.0,
                    child: DropdownButton<Topic>(
                      value: selectedCategory,
                      onChanged: (Topic? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        }
                      },
                      items: snapshot.data!.map<DropdownMenuItem<Topic>>(
                        (Topic topic) {
                          return DropdownMenuItem<Topic>(
                            value: topic,
                            child: Text(topic.id ?? 'No ID'),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Quiz Title'),
                    onChanged: (value) {
                      setState(() {
                        quizTitle = value;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Number of Questions'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        numberOfQuestions = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Quiz Description'),
                    onChanged: (value) {
                      setState(() {
                        quizDescription = value;
                      });
                    },
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedCategory != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizQuestionsPage(
                              category: selectedCategory!.id ?? '',
                              title: quizTitle,
                              numQuestions: numberOfQuestions,
                              description: quizDescription,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text('Next'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
