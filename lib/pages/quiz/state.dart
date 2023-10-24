import 'package:flutter/material.dart';
import 'package:cognize/services/models.dart';

class QuizState with ChangeNotifier {
  final PageController controller = PageController();

  Option? _selectedOption;
  double _quizProgress = 0;

  Option? get selectedOption => _selectedOption;
  double get quizProgress => _quizProgress;

  set selectedOption(Option? option) {
    _selectedOption = option;
    notifyListeners();
  }

  set quizProgress(double value) {
    _quizProgress = value;
    notifyListeners();
  }

  nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
    );
  }
}
