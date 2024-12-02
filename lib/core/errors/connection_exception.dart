import 'package:cep_finder/core/errors/app_exception.dart';

class ConnectionException extends AppException {
  final String originalError;

  ConnectionException({
    required this.originalError,
  }) : super(message: _mountMessage());

  @override
  String toString() {
    return '$runtimeType: $message. OriginalError: $originalError';
  }

  static String _mountMessage() {
    return 'Não foi possível abrir conexão com o servidor.\nTente novamente mais tarde!';
  }
}
