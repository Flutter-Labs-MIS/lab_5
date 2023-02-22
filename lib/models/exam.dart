import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Exam {
  final String id;
  final String name;
  final String date;
  final String time;

  Exam({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
  });
}

class ExamModel extends ChangeNotifier {
  final List<Exam> _exams = [];

  List<Exam> get exams => _exams;

  void addExam(Exam exam) {
    _exams.add(exam);
    notifyListeners();
  }
}
