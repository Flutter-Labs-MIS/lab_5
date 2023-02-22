import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/exam_card.dart';
import '../widgets/new_exam_item_form.dart';
import '../models/exam.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

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

  void _addExamToList(BuildContext context, Exam exam) {
    context.read<ExamModel>().addExam(exam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: context.watch<ExamModel>().exams.isEmpty
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
                  context.watch<ExamModel>().exams[index],
                );
              },
              itemCount: context.watch<ExamModel>().exams.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'exams_calendar');
        },
        child: const Icon(
          Icons.calendar_month,
        ),
      ),
    );
  }
}
