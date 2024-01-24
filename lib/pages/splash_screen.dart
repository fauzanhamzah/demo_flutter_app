import 'package:demo_flutter_app/core/extensions/context_extensions.dart';
import 'package:demo_flutter_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  String _textloading = 'Initial Data...';

  void _changeTextLoading() {
    setState(() {
      _textloading = 'Init Compleate';
    });
  }

  @override
  void initState() {
    super.initState();

    /// For [animation]
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    Future.delayed(const Duration(seconds: 2), () {
      // deleayed code here
      _changeTextLoading();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen()));
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
    _controller.dispose();
    super.dispose();
  }
}
