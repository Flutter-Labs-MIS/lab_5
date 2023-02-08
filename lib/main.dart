import 'package:flutter/material.dart';
import 'package:lab_3/themes/custom_theme.dart';
import 'package:lab_3/utilities/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Reminder',
      theme: CustomTheme.redTheme,
      initialRoute: RouterGenerator.homeRoute,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
