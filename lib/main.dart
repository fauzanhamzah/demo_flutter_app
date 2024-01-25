// import 'package:demo_flutter_app/pages/splash_screen.dart';
import 'dart:io';

import 'package:demo_flutter_app/core/bloc/auth/bloc/auth_bloc.dart';
import 'package:demo_flutter_app/core/bloc/counter/bloc/counter_bloc.dart';
import 'package:demo_flutter_app/core/init/cache/auth_cache_manager.dart';
import 'package:demo_flutter_app/core/init/network/dio_manager.dart';
import 'package:demo_flutter_app/core/service/auth_service.dart';
import 'package:demo_flutter_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            AuthService(DioManager.instance),
            AuthCacheManager(),
          ),
        ),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
