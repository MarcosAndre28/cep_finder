import 'package:flutter/material.dart';

class AppMessenger {
  AppMessenger._();
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey();

  static void showErrorSnackBar(String message, {Duration? duration}) {
    messengerKey.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          elevation: 150.0,
          backgroundColor: const Color(0xFFda5265),
          content: Text(
            message,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          action: SnackBarAction(
            label: 'Fechar',
            textColor: Colors.white,
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        ),
      );
  }
}
