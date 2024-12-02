import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTransitionPageWrapper extends CustomTransitionPage {
  CustomTransitionPageWrapper({
    required super.child,
    super.key,
  }) : super(
          barrierDismissible: true,
          barrierColor: Colors.black38,
          opaque: false,
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
}
