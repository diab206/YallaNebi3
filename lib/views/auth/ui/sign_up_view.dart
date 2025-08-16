import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';
import 'package:yalla_nebi3/core/functions/snackbar_helper.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeView(
                userDataModel: context.read<AuthenticationCubit>().userDataModel!,
              ),
            ),
          );
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
                    const CustomCircleProgressIndicictor(),
                    const SizedBox(height: 16),
                    const Text(
                      'Creating your account...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (kDebugMode)
                      TextButton(
                        onPressed: () {
                          debugPrint('Current state: ${state.runtimeType}');
                          debugPrint('Current user: ${cubit.getCurrentUser()}');
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
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Name Field
                                CustomTextFormField(
                                  controller: nameController,
                                  hintText: 'Full Name',
                                  keyboardType: TextInputType.name,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name is required';
                                    }
                                    if (value.length < 2) {
                                      return 'Name must be at least 2 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Email Field
                                CustomTextFormField(
                                  controller: emailController,
                                  hintText: 'Enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                CustomTextFormField(
                                  controller: passwordController,
                                  hintText: 'Enter your password',
                                  obscureText: _obscurePassword,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
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

                                const SizedBox(height: 32),

                                // Sign Up Button - Full Width
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: state is SignUpLoading
                                        ? null
                                        : () {
                                            if (formKey.currentState!.validate()) {
                                              if (kDebugMode) {
                                                debugPrint('Form validated, calling register...');
                                                debugPrint('Email: ${emailController.text}');
                                                debugPrint('Password length: ${passwordController.text.length}');
                                                debugPrint('Name: ${nameController.text}');
                                              }

                                              cubit.register(
                                                email: emailController.text.trim(),
                                                password: passwordController.text,
                                                name: nameController.text.trim(),
                                              );
                                            } else {
                                              if (kDebugMode) {
                                                debugPrint('Form validation failed');
                                              }
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: state is SignUpLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 32),

                                // Login Link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    CustomTextButton(
                                      text: 'Login',
                                      onTap: () => navigteTo(context, LoginView()),
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