import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';
import 'package:yalla_nebi3/core/functions/nackbar_helper.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/core/widgets/elvated_button.dart';
import 'package:yalla_nebi3/core/widgets/text_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';
import 'package:yalla_nebi3/views/nav_bar/ui/main_home_view.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacementNamed(context, MainHomeView.routeName);
        }
        if (state is SignUpFailure) {
          showAppSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Welcome to our market',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: state is SignUpLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleProgressIndicictor(),
                    const SizedBox(height: 16),
                    const Text('Creating your account...'),
                    const SizedBox(height: 8),
                    if (kDebugMode)
                      TextButton(
                        onPressed: () {
                          // Debug button to check current state
                          print('Current state: ${state.runtimeType}');
                          print('Current user: ${cubit.getCurrentUser()}');
                        },
                        child: const Text('Debug Current State'),
                      ),
                  ],
                )
              : SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: formKey,
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
                                    controller: nameController,
                                    hintText: 'Name',
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
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
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  /// Sign Up Row
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
                                          if (formKey.currentState!.validate()) {
                                            if (kDebugMode) {
                                              print('Form validated, calling register...');
                                              print('Email: ${emailController.text}');
                                              print('Password length: ${passwordController.text.length}');
                                              print('Name: ${nameController.text}');
                                            }

                                            cubit.register(
                                              email: emailController.text.trim(),
                                              password: passwordController.text,
                                              name: nameController.text.trim(),
                                            );
                                          } else {
                                            if (kDebugMode) {
                                              print('Form validation failed');
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  /// Sign Up with Google Row
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
                                          // TODO: Implement Google sign up
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}