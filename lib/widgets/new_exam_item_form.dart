import 'package:flutter/material.dart';
import 'package:lab_3/models/exam.dart';
import 'package:nanoid/nanoid.dart';

class NewExamItemForm extends StatefulWidget {
  final Function addItemFunction;

  const NewExamItemForm(this.addItemFunction, {super.key});

  @override
  State<StatefulWidget> createState() => _NewExamItemFormState();
}

class _NewExamItemFormState extends State<NewExamItemForm> {
  final _examNameController = TextEditingController();
  final _examDateTimeController = TextEditingController();

  // late String examName;
  // late String examDateTime;

  void _submitForm() {
    if (_examNameController.text.isEmpty ||
        _examDateTimeController.text.isEmpty) {
      return;
    }

    final String examName = _examNameController.text;
    final String examDateTime = _examDateTimeController.text;

    final Exam e = Exam(id: nanoid(4), name: examName, dateTime: examDateTime);

    widget.addItemFunction(e);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _examNameController,
            decoration: const InputDecoration(labelText: "Exam name"),
            onSubmitted: (_) => _submitForm,
          ),
          TextField(
            controller: _examDateTimeController,
            decoration: const InputDecoration(labelText: "Exam Date and Time"),
            onSubmitted: (_) => _submitForm,
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
