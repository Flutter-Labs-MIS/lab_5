import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      body: TableCalendar(
        firstDay: DateTime(1990),
        lastDay: DateTime(2100),
        focusedDay: DateTime.now(),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
