abstract class IAppException implements Exception {
  final String message;
  final StackTrace stackTrace;

  IAppException({
    required this.message,
    required this.stackTrace,
  });
}

class AppException extends IAppException {
  AppException({
    required super.message,
    StackTrace? stackTrace,
  }) : super(stackTrace: stackTrace ?? StackTrace.current);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}
