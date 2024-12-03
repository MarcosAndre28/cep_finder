import 'dart:convert';
import 'dart:io';

import 'app_exception.dart';

class ApiException extends AppException {
  final String apiMessage;
  final int httpStatusCode;

  ApiException({
    required this.apiMessage,
    required this.httpStatusCode,
  }) : super(message: _mountMessage(apiMessage, httpStatusCode));

  @override
  String toString() {
    return '$runtimeType: $message. ApiMessage: $apiMessage (statusCode $httpStatusCode)';
  }

  static String _mountMessage(String message, int httpStatusCode) {
    switch (httpStatusCode) {
      case HttpStatus.unauthorized:
        return 'Verifique usuário ou senha';
    }

    try {
      final map = json.decode(message);
      if (map != null) {
        final msg = map['message'];
        if (msg != null) {
          return msg.toString();
        }
      }
    } catch (_) {}

    return 'Cep não encontrado. Por favor verifique os dados digitados e tente novamente';
  }
}
