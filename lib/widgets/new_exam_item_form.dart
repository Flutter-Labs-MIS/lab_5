import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final _examDateController = TextEditingController();
  final _examTimeController = TextEditingController();

  // late String examName;
  // late String examDateTime;

  void _submitForm() {
    if (_examNameController.text.isEmpty ||
        _examDateController.text.isEmpty ||
        _examNameController.text.isEmpty) {
      return;
    }

    final String examName = _examNameController.text;
    final String examDate = _examDateController.text;
    final String examTime = _examTimeController.text;

    final Exam e =
        Exam(id: nanoid(4), name: examName, date: examDate, time: examTime);

    widget.addItemFunction(e);
    Navigator.of(context).pop();
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (date == null) return;
    String formattedDate = DateFormat("dd/MM/yyyy").format(date);
    _examDateController.text = formattedDate.toString();
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;
    String hour = time.hour.toString();
    String minute = time.minute.toString();
    _examTimeController.text = "$hour:$minute";
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
            controller: _examDateController,
            readOnly: true,
            decoration: const InputDecoration(labelText: "Exam Date"),
            onSubmitted: (_) => _submitForm,
            onTap: _selectDate,
          ),
          TextField(
            controller: _examTimeController,
            readOnly: true,
            decoration: const InputDecoration(labelText: "Exam Time"),
            onSubmitted: (_) => _submitForm,
            onTap: _selectTime,
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
