import 'package:flutter/material.dart';
import 'package:lab_3/models/exam.dart';
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
  final List<ExamCard> _exams = [];

  void _addExamToList() {
    ExamCard el = ExamCard(Exam(
        id: 1,
        name: "Structural Programming",
        dateTime: "12:12:12 12/12/2012"));
    setState(() {
      _exams.add(el);
    });
  }

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
              onTap: _addExamToList,
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
                  _exams[index].exam,
                );
              },
              itemCount: _exams.length,
            ),
    );
  }
}
