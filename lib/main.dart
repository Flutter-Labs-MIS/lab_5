import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: RouterGenerator.homeRoute,
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
