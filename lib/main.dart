import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:yalla_nebi3/core/config/sensitive_data.dart';
import 'package:yalla_nebi3/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/features/auth/presentation/screens/login_view.dart';
import 'package:yalla_nebi3/features/navbar/presentation/screens/main_home_view.dart';
import 'package:yalla_nebi3/features/welcome/presentation/screens/splash_screen.dart';
import 'package:yalla_nebi3/views/auth/ui/sign_up_view.dart';
import 'package:yalla_nebi3/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSupabase();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const YallaNebi3(),
    ),
  );
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
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        title: 'YallaNebi3',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const SplashScreen(), // always start here
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
          LoginView.routeName: (context) => LoginView(),
          SignUpView.routeName: (context) => const SignUpView(),
          MainHomeView.routeName: (context) => const MainHomeView(),
        },
      ),
    );
  }
}
