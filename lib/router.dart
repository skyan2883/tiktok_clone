import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screens/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screens/email_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screens/username_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          name: UsernameScreen.routeName,
          path: UsernameScreen.routeURL,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   name: 'username_screen',
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     print("UsernameScreen");
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),

    GoRoute(
      path: LoginFormScreen.routeName,
      builder: (context, state) => const LoginFormScreen(),
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters['username'] ?? 'Unknown';
        final tab = state.uri.queryParameters['show'];
        return MainNavigationScreen(
          initialTab: 4,
          tmp1: username,
          tmp2: tab,
        );
      },
    ),
  ],
);
