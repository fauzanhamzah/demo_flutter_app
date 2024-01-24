// import 'package:demo_flutter_app/pages/splash_screen.dart';
import 'package:demo_flutter_app/core/bloc/counter/bloc/counter_bloc.dart';
import 'package:demo_flutter_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
