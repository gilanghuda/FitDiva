import 'package:fitdiva/features/data/datasource/auth_service.dart';
import 'package:fitdiva/features/presentation/view/onboarding_screen.dart';
import 'package:fitdiva/features/presentation/view/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/presentation/view/login.dart';
import 'package:provider/provider.dart';
import 'package:fitdiva/features/presentation/provider/auth_provider.dart';
import 'package:fitdiva/di/injection_container.dart';
import 'di/injection_container.dart' as di;
import 'package:fitdiva/features/presentation/router/approuter.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.setupDependencyInjection(); // Initialize dependency injection
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());

  // Future.delayed(const Duration(seconds: 2), () {
  //   FlutterNativeSplash.remove();
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
              loginUser: di.sl(),
              registerUser: di.sl(),
              authService: FirebaseAuthService()),
          ), // Provide AuthProvider
        // Add other providers here as needed
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'FitDiva',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: appRouter,
      ),
    );
  }
}



