import 'package:flutter/material.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';
import 'package:yalla_nebi3/views/auth/ui/sign_up_view.dart';
import 'package:yalla_nebi3/views/nav_bar/ui/main_home_view.dart';
import 'package:yalla_nebi3/welcome/splash_screen.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute:MainHomeView .routeName,
      routes: {
         SplashScreen.routeName: (context) => const SplashScreen(),
         WelcomeScreen.routeName: (context) => const WelcomeScreen(),
         LoginView.routeName: (context) =>  LoginView(),     
         SignUpView.routeName: (context) => const SignUpView(),
          MainHomeView.routeName: (context) => MainHomeView(),
        // Add other routes here as needed
      },
    );
  }
}
