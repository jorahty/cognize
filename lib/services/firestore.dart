import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cognize/services/auth.dart';
import 'package:cognize/services/models.dart';

// This service is responsible for interacting with the Firestore database

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data()!);
  }

  updateUserReport(Quiz quiz) {
    final user = AuthService().user!;
    final ref = _db.collection('reports').doc(user.uid);

    final fields = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id]),
      },
    };

    return ref.set(fields, SetOptions(merge: true));
  }

  Future<void> submitQuiz(Quiz quiz) async {
    try {
      // Convert quiz to Map
      Map<String, dynamic> quizData = quiz.toJson();
      print(quizData);

      // Submit quiz to Firestore
      await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(quiz.id)
          .set(quizData);

      print('Quiz submitted to Firestore!');
    } catch (error) {
      print('Error submitting quiz to Firestore: $error');
    }
  }

  Future<Topic?> getTopicByCategory(String category) async {
    try {
      var snapshot =
          await _db.collection('topics').where('id', isEqualTo: category).get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        return Topic.fromJson(data);
      }
      return null;
    } catch (error) {
      print('Error getting topic by category: $error');
      return null;
    }
  }

  Future<void> updateTopicWithQuiz(Topic topic, Quiz quiz) async {
    try {
      // Append the new quiz to the existing list of quizzes
      // Update the topic in Firestore
      await _db.collection('topics').doc(topic.id).update({
        'quizzes': topic.quizzes.map((quiz) => quiz.toJson()).toList(),
      });

      print('Topic updated with new quiz in Firestore!');
    } catch (error) {
      print('Error updating topic with new quiz in Firestore: $error');
    }
  }

  Stream<Report> userReportStream() {
    return AuthService().authStream.switchMap((user) {
      if (user != null) {
        final ref = _db.collection('reports').doc(user.uid);

        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      }

      return Stream.fromIterable([Report()]);
    });
  }
}
