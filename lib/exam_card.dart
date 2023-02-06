import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  final String examName;
  final String dateTime;

  const ExamCard(this.examName, this.dateTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              examName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              dateTime,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(180, 180, 180, 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
