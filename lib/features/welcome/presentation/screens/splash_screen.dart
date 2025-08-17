import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/constants/app_colors.dart';
import 'package:yalla_nebi3/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/features/navbar/presentation/screens/main_home_view.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _checkAuth);
  }

  void _checkAuth() {
    final cubit = context.read<AuthenticationCubit>();
    final session = cubit.client.auth.currentSession;

    // ignore: unnecessary_null_comparison
    if (session != null && session.user != null) {
      Navigator.pushReplacementNamed(context, MainHomeView.routeName);
    } else {
      Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: Center(
        child: Image.asset(
          'assets/images/splash_logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
