import 'package:flutter/material.dart';
import 'package:lab_3/screens/login_page.dart';
import 'package:lab_3/screens/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text("Login"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
