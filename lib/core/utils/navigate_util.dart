import 'package:flutter/material.dart';

class NavigateUtil {
  void navigateToView(BuildContext context, Widget route) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => route));
  }
}
