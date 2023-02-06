import 'package:flutter/material.dart';
import 'exam_card.dart';

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
      home: const MyHomePage(title: 'Exam Reminder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ExamCard> _exams = [
    const ExamCard(
      "Structural Programming",
      "12/12/2022 12:12:12",
    ),
    const ExamCard(
      "Object-oriented Programming",
      "12/12/2022 12:12:12",
    ),
    const ExamCard(
      "Algorithms and Data structures",
      "12/12/2022 12:12:12",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () => {},
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: _exams.isEmpty
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
                  _exams[index].examName,
                  _exams[index].dateTime,
                );
              },
              itemCount: _exams.length,
            ),
    );
  }
}
