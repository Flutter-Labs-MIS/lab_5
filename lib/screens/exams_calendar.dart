import 'package:flutter/material.dart';

class ExamsCalendar extends StatefulWidget {
  const ExamsCalendar({Key? key});

  @override
  State<StatefulWidget> createState() => _ExamsCalendarState();
}

class _ExamsCalendarState extends State<ExamsCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Calendar"),
      ),
    );
  }
}
