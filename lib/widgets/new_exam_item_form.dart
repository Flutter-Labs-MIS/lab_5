import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lab_3/models/exam.dart';
import 'package:nanoid/nanoid.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

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
  final _examLocationController = TextEditingController();

  var uuid = const Uuid();
  String _sessionToken = "12345";

  static const String baseURL =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  static const String kGoogleApiPlaces =
      "AIzaSyALsaua0KDR9lPTXU3oPbw4a-9o_dcyH9E";

  List<dynamic> _placesList = [];

  // late String examName;
  // late String examDateTime;

  @override
  void initState() {
    super.initState();
    _examLocationController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(_examLocationController.text);
  }

  void getSuggestion(String input) async {
    String request =
        '$baseURL?input=$input&key=$kGoogleApiPlaces&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  void _submitForm() {
    if (_examNameController.text.isEmpty ||
        _examDateController.text.isEmpty ||
        _examNameController.text.isEmpty ||
        _examLocationController.text.isEmpty) {
      return;
    }

    final String examName = _examNameController.text;
    final String examDate = _examDateController.text;
    final String examTime = _examTimeController.text;
    final String examLocation = _examLocationController.text;

    final Exam e = Exam(
      id: nanoid(4),
      name: examName,
      date: examDate,
      time: examTime,
      location: examLocation,
    );

    widget.addItemFunction(context, e);

    Navigator.pop(context);
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
      height: double.infinity,
      padding: const EdgeInsets.all(5),
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
          TextField(
            controller: _examLocationController,
            decoration: const InputDecoration(
              labelText: "Exam Location",
              hintText: "Search location",
            ),
            onSubmitted: (_) => _submitForm,
            onChanged: getSuggestion,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _placesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    _examLocationController.text =
                        _placesList[index]['description'];
                  },
                  title: Text(_placesList[index]['description']),
                );
              },
            ),
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
