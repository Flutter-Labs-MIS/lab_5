import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Text(
              "Exam Name",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Exam Date and Time",
              style: TextStyle(
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
