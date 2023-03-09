import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_3/screens/home.dart';
import 'package:lab_3/screens/welcome_page.dart';
import 'package:provider/provider.dart';

import '../models/exam.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  String errorEmail = "";
  String errorPassword = "";

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _clearExamsList(context);
    super.initState();
  }

  void _clearExamsList(BuildContext context) {
    context.read<ExamModel>().clearList();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const WelcomePage(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 30,
          ),
        ),
        title: const Text("Register"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@mail.com",
                  errorText: errorEmail != '' ? errorEmail : null,
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: errorPassword != '' ? errorPassword : null,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  setState(() {
                    errorEmail = '';
                    errorPassword = '';
                  });
                  try {
                    var registerNewUser = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(registerNewUser.user?.uid)
                        .set({
                      'id': registerNewUser.user?.uid,
                      'email': registerNewUser.user?.email,
                      'exams': []
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Home(
                          title: "Exam Reminder",
                        ),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == "email-already-in-use") {
                        errorEmail = e.message.toString();
                      }
                      if (e.code == "weak-password") {
                        errorPassword = e.message.toString();
                      }
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: const Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
