import 'package:fitdiva/features/presentation/router/approutes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/Homepage_Screen.dart';
import '../view/login.dart';
import '../view/register.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to Splash Screen');
        return const Scaffold(
          body: Center(child: Text('Splash Screen')),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.homepage,
      name: 'homepage',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to HomepageScreen');
        return HomepageScreen();
      },
    ),
  
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to Profile Screen');
        return const Scaffold(
          body: Center(child: Text('Profile Screen')),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to LoginScreen');
        return LoginScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (BuildContext context, GoRouterState state) {
        print('Navigating to RegisterScreen');
        return RegisterScreen();
      },
    ),
  ],
);