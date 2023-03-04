import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/exam_card.dart';
import '../widgets/new_exam_item_form.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showExams(context);
    });
    super.initState();
  }

  void _showExams(BuildContext context) {
    context.read<ExamModel>().showExamList();
  }

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
        leading: 
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
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
              onTap: () => _showModalForm(context),
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
