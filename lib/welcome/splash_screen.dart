import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>  WelcomeScreen()),
        (Route<dynamic> route) => false, // Remove all routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColors.backgroundcolor ,

  body: Center(
        child: SizedBox(
          width: 300, // Set the width of the logo
          height: 300, // Set the height of the logo
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_logo.png'),
                fit: BoxFit.contain, // Ensures the logo fits within the SizedBox
              ),
            ),
          ),
        ),
      ),
    );
  }
}