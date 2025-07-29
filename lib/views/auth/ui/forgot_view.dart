import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/custom_circle_indicitor.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/functions/nackbar_helper.dart';
import 'package:yalla_nebi3/core/widgets/custom_action_button.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';

class ForgotView extends StatefulWidget {
  static const String routeName = 'forgot_view';

  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is ResetpasswordSuccess) {
          showAppSnackBar(context, 'Password reset email sent successfully.');
          Navigator.pop(context); // Navigate back after successful reset
        } else if (state is ResetpasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send password reset email.')),
          );
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: buildCustomAppBar(
            context,
            'Enter your email To Reset Password',
          ),
          body:
              state is ResetpasswordLoading
                  ? CustomCircleProgressIndicictor()
                  : SafeArea(
                    child: Form(
                      key: formKey,
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
                                    CustomActionButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.resetPassword(
                                            emailController.text,
                                          );
                                        }
                                      },
                                      text: "sumbit",
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
    super.dispose();
  }
}
