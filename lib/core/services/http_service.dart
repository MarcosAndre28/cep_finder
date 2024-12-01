import 'package:cep_finder/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class IHttpService {
  Future<Response<T>> get<T>(
      String endpoint, [
        Map<String, dynamic>? queryParameters,
      ]);
}

class HttpServiceImpl implements IHttpService {
  HttpServiceImpl() {
    _dio.options.baseUrl = Constants.baseApiUrl;
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    ]);
  }

  final Dio _dio = Dio();


  @override
  Future<Response<T>> get<T>(
      String endpoint, [
        Map<String, dynamic>? queryParameters,
      ]) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
