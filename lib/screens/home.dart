import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_3/screens/add_exam.dart';
import 'package:provider/provider.dart';
import '../widgets/exam_card.dart';
import '../models/exam.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _showExams(context);
    super.initState();
  }

  void _showExams(BuildContext context) {
    context.read<ExamModel>().showExamList();
  }
  
  void _clearExamsList(BuildContext context) {
    context.read<ExamModel>().clearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            _clearExamsList;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            );
          },
          child: const Icon(
            Icons.logout_rounded,
            size: 30,
          ),
        ),
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: GestureDetector(
              onTap: () =>  Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddExam(),
              ),
            ),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
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
              itemCount: context.watch<ExamModel>().exams.length,
              itemBuilder: (ctx, index) {
                return ExamCard(
                  context.watch<ExamModel>().exams[index],
                );
              },
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
