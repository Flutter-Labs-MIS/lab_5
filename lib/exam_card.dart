import 'package:flutter/material.dart';
import 'models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard(this.exam, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              exam.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Date: ${exam.date} Time: ${exam.time}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(180, 180, 180, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
