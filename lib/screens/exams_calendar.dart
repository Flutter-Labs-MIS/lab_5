import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_3/models/exam.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/exam_card.dart';

class ExamsCalendar extends StatefulWidget {
  const ExamsCalendar({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ExamsCalendarState();
}

class _ExamsCalendarState extends State<ExamsCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<Exam> _getExamsForDay(BuildContext context, DateTime day) {
    return context
        .watch<ExamModel>()
        .exams
        .where(
            (element) => element.date == DateFormat("dd/MM/yyyy").format(day))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Calendar"),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(1990),
            lastDay: DateTime(2100),
            focusedDay: DateTime.now(),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) => _getExamsForDay(context, day),
          ),
          Expanded(
            child: _getExamsForDay(context, _selectedDay).isEmpty
                ? const Center(
                    child: Text(
                      "There are no exams added",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return ExamCard(
                        _getExamsForDay(context, _selectedDay)[index],
                      );
                    },
                    itemCount: _getExamsForDay(context, _selectedDay).length,
                  ),
          )
        ],
      ),
    );
  }
}
