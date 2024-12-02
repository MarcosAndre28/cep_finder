import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cep_finder/core/common/widgets/app_messenger.dart';
import 'package:cep_finder/core/errors/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocSafeRun<BlocEvent, BlocState> on Bloc<BlocEvent, BlocState> {
  void onSafe<E extends BlocEvent>(
    EventHandler<E, BlocState> handler, {
    EventTransformer<E>? transformer,
    BlocState Function(String message)? errorState,
    bool Function(Exception exception, String message, Emitter<BlocState> emitter, E blocEvent)? exceptionHandler,
  }) {
    on<E>(
      (E blocEvent, Emitter<BlocState> emitter) async {
        try {
          await handler(blocEvent, emitter);
        } catch (e, s) {
          _log(e, s);

          String errorMessage = _getErrorMessage(e);

          bool shouldShowDefaultMessage = errorState != null ? false : true;
          if (e is Exception && exceptionHandler != null) {
            shouldShowDefaultMessage = !exceptionHandler(e, errorMessage, emitter, blocEvent);
          }

          if (errorState != null) {
            emitter(errorState(errorMessage));
          }

          if (shouldShowDefaultMessage) {
            AppMessenger.showErrorSnackBar(errorMessage);
          }
        }
      },
      transformer: transformer,
    );
  }

  String _getErrorMessage(Object e) {
    if (e is Exception) {
      return _getExceptionMessage(e);
    }

    return 'Ocorreu um erro crítico: ${e.toString()}';
  }

  String _getExceptionMessage(Exception e) {
    if (e is IAppException) {
      return e.message;
    }

    return 'Erro desconhecido: ${e.toString()}';
  }

  void _log(Object e, StackTrace s) {
    //TODO salvar log
    log('Ocorreu um erro ${e.toString()}', error: e, stackTrace: s);
  }
}
