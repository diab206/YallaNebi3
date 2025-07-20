import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/views/auth/ui/login_view.dart';
import 'package:yalla_nebi3/views/auth/ui/sign_up_view.dart';
import 'package:yalla_nebi3/views/nav_bar/ui/main_home_view.dart';
import 'package:yalla_nebi3/views/product_details/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/welcome/splash_screen.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await _initializeSupabase();
  runApp(const YallaNebi3());
}

Future<void> _initializeSupabase() async {
  try {
    // Load environment variables from .env file
    await dotenv.load(fileName: ".env");
    
    // Get credentials from environment variables
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
    
    // Validate that required environment variables are present
    if (supabaseUrl == null || supabaseUrl.isEmpty) {
      throw Exception('SUPABASE_URL not found in .env file');
    }
    
    if (supabaseAnonKey == null || supabaseAnonKey.isEmpty) {
      throw Exception('SUPABASE_ANON_KEY not found in .env file');
    }
    
    // Initialize Supabase with environment variables
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  } catch (e) {
    // Log error and rethrow to prevent app from starting with invalid config
    throw Exception('Failed to initialize Supabase: $e');
  }
}

class YallaNebi3 extends StatelessWidget {
  const YallaNebi3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        title: 'YallaNebi3',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
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