import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';
import 'package:yalla_nebi3/core/functions/nackbar_helper.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/core/widgets/elvated_button.dart';
import 'package:yalla_nebi3/core/widgets/text_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/views/auth/ui/forgot_view.dart';
import 'package:yalla_nebi3/views/auth/ui/sign_up_view.dart';
import 'package:yalla_nebi3/views/nav_bar/ui/main_home_view.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainHomeView()),
          );
        }
        if (state is LoginFailure) {
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
          body:
              state is LoginLoading
                  ? CustomCircleProgressIndicictor()
                  : SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
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

                                    /// Password Field with Eye Icon
                                    CustomTextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                            _obscurePassword =
                                                !_obscurePassword;
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

                                    /// Forgot Password
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomTextButton(
                                          text: 'Forgot Password?',
                                          onTap: () {
                                            navigteTo(context, ForgotView());
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 24),

                                    /// Login Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        CustomElevatedIconButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              cubit.login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    /// Login with Google Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Login With Google',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        CustomElevatedIconButton(
                                          onPressed:
                                              () => navigteTo(
                                                context,
                                                MainHomeView(),
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don\'t have an account? ',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        CustomTextButton(
                                          text: 'Sign Up',
                                          onTap: () {
                                            navigteTo(context, SignUpView());
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
