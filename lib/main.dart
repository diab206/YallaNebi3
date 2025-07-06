import 'package:flutter/material.dart';
import 'package:yalla_nebi3/welcome/splash_screen.dart';

void main() {
  runApp(const YallaNebi3());
}

class YallaNebi3 extends StatelessWidget {
  const YallaNebi3({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YallaNebi3',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const   SplashScreen(),
    );
  }
}
