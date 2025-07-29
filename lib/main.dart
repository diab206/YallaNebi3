import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/sensetive_data.dart';

import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';
import 'package:yalla_nebi3/views/auth/ui/sign_up_view.dart';
import 'package:yalla_nebi3/views/nav_bar/ui/main_home_view.dart';
import 'package:yalla_nebi3/welcome/splash_screen.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSupabase();
  runApp(const YallaNebi3());
}

Future<void> _initializeSupabase() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: anonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );
}

class YallaNebi3 extends StatelessWidget {
  const YallaNebi3({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient client = Supabase.instance.client;

    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        title: 'YallaNebi3',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute:
            client.auth.currentSession != null
                ? MainHomeView.routeName
                : SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
          LoginView.routeName: (context) => LoginView(),
          SignUpView.routeName: (context) => const SignUpView(),
          MainHomeView.routeName: (context) => MainHomeView(),
        },
      ),
    );
  }
}
