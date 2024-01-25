import 'dart:async';

import 'package:demo_flutter_app/core/bloc/auth/bloc/auth_bloc.dart';
import 'package:demo_flutter_app/core/extensions/context_extensions.dart';
import 'package:demo_flutter_app/core/extensions/navigate_extension.dart';
import 'package:demo_flutter_app/core/utils/navigate_util.dart';
// import 'package:demo_flutter_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  final String _textloading = 'Initial Data...';
  late final AuthBloc authBloc;
  late StreamSubscription authStream;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>()..add(AppStarted());

    /// For [animation]
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    authStream = authBloc.stream.listen((state) {
      Future.delayed(const Duration(seconds: 2)).then((_) =>
          NavigateUtil().navigateToView(context, state.status.firstView));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _animation,
            child: Center(
              child: Image.asset(
                'assets/images/demo.png',
                height: context.dynamicHeight(0.2),
                width: context.dynamicWidth(0.9),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(_textloading)
        ],
      ),
    );
  }

  @override
  void dispose() {
    authStream.cancel();
    _controller.dispose();
    super.dispose();
  }
}
