import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/widgets/text_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart'; // Use your reusable field

class LoginView extends StatefulWidget {
  static const String routeName = 'login';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                /// Email Field
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Password Field with Eye Icon
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                /// Login Button
                ElevatedButton(
                  onPressed: () {
                    // Validate or submit logic
                    if (kDebugMode) {
                      print('Email: ${emailController.text}');
                    }
                    if (kDebugMode) {
                      print('Password: ${passwordController.text}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Login'),
                ),

                const SizedBox(height: 16),

                /// Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      onTap: (){},
                      text: 'Forgot Password?',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
