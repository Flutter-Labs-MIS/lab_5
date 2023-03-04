import 'package:flutter/material.dart';
import 'package:lab_3/screens/exams_calendar.dart';
import 'package:lab_3/screens/home.dart';
import 'package:lab_3/screens/login_page.dart';
import 'package:lab_3/screens/register_page.dart';
import 'package:lab_3/screens/welcome_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'welcome':
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );
      case 'home':
        return MaterialPageRoute(
          builder: (_) => const Home(
            title: "Exam Reminder",
          ),
        );
      case 'exams_calendar':
        return MaterialPageRoute(
          builder: (_) => const ExamsCalendar(),
        );
      case 'login':
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case 'register':
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );
      default:
        return _error();
    }
  }

  static String homeRoute = 'welcome';

  static Route<dynamic> _error() {
    return MaterialPageRoute(
      builder: (_) => const Text(
        '404: Not Found',
      ),
    );
  }
}
