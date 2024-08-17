import 'package:dima_project_2023/src/logic/authentication/login.dart';
import 'package:dima_project_2023/src/pages/authentication/forgot_password.dart';
import 'create_account.dart';
import 'package:flutter/material.dart';
import 'package:dima_project_2023/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      ]
                    )
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (() => LoginLogic.login(
                        context, _emailController.text, _passwordController.text)),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: const Text(
                        'Do not have an account yet? Click here to register'), // Button text
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
