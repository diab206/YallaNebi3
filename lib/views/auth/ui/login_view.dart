import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, });

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Login View',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle login action
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}