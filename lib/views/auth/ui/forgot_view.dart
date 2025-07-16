import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/widgets/custom_action_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';

class ForgotView extends StatelessWidget {
  static const String routeName = 'forgot_view';
  ForgotView({super.key});
    final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Email To Reset Password',style: TextStyle(fontSize: 24)),
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
                        'Login',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
      CustomActionButton(onPressed: (){},text: "sumbit")
                   
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