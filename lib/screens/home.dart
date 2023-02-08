import 'package:flutter/material.dart';
import '../widgets/exam_card.dart';
import '../widgets/new_exam_item_form.dart';
import '../models/exam.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ExamCard> _exams = [];

  void _showModalForm(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () => {},
          behavior: HitTestBehavior.opaque,
          child: NewExamItemForm(_addExamToList),
        );
      },
    );
  }

  void _addExamToList(Exam exam) {
    setState(() {
      _exams.add(ExamCard(exam));
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
              onTap: () => _showModalForm(context),
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
