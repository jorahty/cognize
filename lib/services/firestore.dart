import 'package:cloud_firestore/cloud_firestore.dart';
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
}
