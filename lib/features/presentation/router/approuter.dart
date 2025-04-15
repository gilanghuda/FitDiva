import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitdiva/features/presentation/router/approutes.dart';
import 'package:fitdiva/features/presentation/view/exercise_screen.dart';
import 'package:fitdiva/features/presentation/view/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/Homepage_Screen.dart';
import '../view/activity_screen.dart';
import '../view/calendar_screen.dart';
import '../view/profile_screen.dart';
import '../view/navbar/Navigation.dart';
import '../view/login.dart';
import '../view/register.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(),
              );
            } else {
              final user = snapshot.data;
              if (user != null) {
                return NavbarScreen();
              } else {
                return OnboardingScreen();
              }
            }
          },
        );
      },
    ),
    GoRoute(
      path: AppRoutes.navbar,
      name: 'navbar',
      builder: (BuildContext context, GoRouterState state) {
        return const NavbarScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.homepage,
      name: 'homepage',
      builder: (BuildContext context, GoRouterState state) {
        return const HomepageScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.activity,
      name: 'activity',
      builder: (BuildContext context, GoRouterState state) {
        return const ActivityScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.calendar,
      name: 'calendar',
      builder: (BuildContext context, GoRouterState state) {
        return const CalendarScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
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
    GoRoute(
      path: AppRoutes.exercise,
      name: 'exercise',
      builder: (BuildContext context, GoRouterState state) {
        final extra =
            state.extra as Map<String, dynamic>?; // Extract parameters
        return ExerciseScreen(
          title: extra?['title'] ?? 'Exercise',
          imageUrl: extra?['imageUrl'] ?? '',
          duration: extra?['duration'] ?? 0,
        );
      },
    ),
  ],
);
