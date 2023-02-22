import 'package:flutter/material.dart';
import 'package:lab_3/screens/exams_calendar.dart';
import 'package:lab_3/screens/home.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(
          builder: (_) => const Home(
            title: "Exam Reminder",
          ),
        );
      case 'exams_calendar':
        return MaterialPageRoute(
          builder: (_) => ExamsCalendar(),
        );
      default:
        return _error();
    }
  }

  static String homeRoute = 'home';

  static Route<dynamic> _error() {
    return MaterialPageRoute(
      builder: (_) => const Text(
        '404: Not Found',
      ),
    );
  }
}
