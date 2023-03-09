import 'package:flutter/material.dart';
import 'package:lab_3/widgets/new_exam_item_form.dart';
import 'package:provider/provider.dart';

import '../models/exam.dart';

class AddExam extends StatefulWidget {
  const AddExam({super.key});

  @override
  State<AddExam> createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  void _addExamToList(BuildContext context, Exam exam) {
    context.read<ExamModel>().addExam(exam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Exam"),
      ),
      body: NewExamItemForm(_addExamToList),
    );
  }
}