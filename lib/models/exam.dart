import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Exam {
  final String id;
  final String name;
  final String date;
  final String time;
  final String location;

  Exam({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.location,
  });
}

class ExamModel extends ChangeNotifier {
  List<Exam> exams = <Exam>[];

  void showExamList() async {
    exams = <Exam>[];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      List.from(value.data()!['exams']).forEach((exam) {
        Exam data = Exam(
          id: exam['id'],
          name: exam['name'],
          date: exam['date'],
          time: exam['time'],
          location: exam['location'],
        );

        exams.add(data);
      });
    });
    notifyListeners();
  }

  void clearList() {
    exams = <Exam>[];
  }

  void addExam(Exam exam) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(
      {
        'exams': FieldValue.arrayUnion([
          {
            'id': exam.id,
            'name': exam.name,
            'date': exam.date,
            'time': exam.time,
            'location': exam.location,
          }
        ]),
      },
      SetOptions(merge: true),
    );
    exams.add(exam);
    notifyListeners();
  }
}
