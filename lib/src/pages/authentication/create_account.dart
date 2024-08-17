import 'package:dima_project_2023/main.dart';
import 'package:dima_project_2023/src/logic/authentication/create_account.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: ((context, orientation) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/logo.png',
                  ),
                  SizedBox(
                    width: (deviceType == 1 && orientation == Orientation.landscape) ? 600 : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        TextField(
                          controller: _passwordCheckerController,
                          decoration:
                              const InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                        ),
                      ]
                    )
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => RegistrationLogic.register(
                        context,
                        _emailController.text,
                        _passwordController.text,
                        _passwordCheckerController.text),
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                        'Already have an account? Click here to log-in'), // Button text
                  ),
                ],
              ),
            ),
          ),
        );
      }),)
    );
  }
}
