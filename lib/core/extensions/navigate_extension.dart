import 'package:demo_flutter_app/core/constants/enums/auth_enums.dart';
import 'package:demo_flutter_app/pages/home.dart';
import 'package:demo_flutter_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

extension NavigateExtension on AuthStatus {
  Widget get firstView {
    switch (this) {
      case AuthStatus.authenticated:
        return const HomePage();
      case AuthStatus.guest:
        return const LoginScreen();
      case AuthStatus.unknown:

        /// MARK: It can be IntroView.
        break;
    }
    return const LoginScreen();
  }
}
