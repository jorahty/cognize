import 'package:flutter/material.dart';

class SearchState with ChangeNotifier {
  TextEditingController controller = TextEditingController();
  var input = "";

  setInput(text) {
    input = text;
    notifyListeners();
  }
}
