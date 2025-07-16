import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/core/widgets/elvated_button.dart';
import 'package:yalla_nebi3/core/widgets/text_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';

class SignUpView extends StatefulWidget {
  static const String routeName = 'signup';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to our market',style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
             CustomTextFormField( 
               controller:nameController ,
               hintText: 'Name',
               keyboardType: TextInputType.name,
             ),
              const SizedBox(height: 16),
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
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        hintText: 'Enter your password',
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
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
                      const SizedBox(height: 16),
          
                     
         
          
                      /// Login Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomElevatedIconButton(
                            onPressed: () {
                              if (kDebugMode) {
                                print('Email: ${emailController.text}');
                                print('Password: ${passwordController.text}');
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
          
                      /// Login with Google Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign Up With Google',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomElevatedIconButton(
                            onPressed: () {
                              // Google login action
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 22),
                        ),
                        CustomTextButton(
                          text: 'Login',
                          onTap: () {
                           navigteTo(context, LoginView());
                          },
                        ),
                      ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
