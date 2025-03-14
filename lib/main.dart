import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moticar/bloc/login_bloc.dart';
import 'package:moticar/bloc/splash_bloc.dart';
import 'package:moticar/screens/login_screen.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()..add(SplashStarted())),
        BlocProvider(create: (context) => LoginBloc())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashLoaded) {
            return const LoginScreen();
          } else {
            return const SplashScreen();
          }
        },
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
