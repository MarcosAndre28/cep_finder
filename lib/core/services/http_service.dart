import 'dart:convert';
import 'dart:io';

import 'package:cep_finder/core/errors/api_exception.dart';
import 'package:cep_finder/core/errors/connection_exception.dart';
import 'package:cep_finder/core/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class IHttpService {
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}

class HttpServiceImpl implements IHttpService {
  HttpServiceImpl(this.httpClient);

  final http.Client httpClient;

  String _getBaseUrl() {
    return Constants.baseApiUrl;
  }

  @override
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool ecommerceApi = false,
  }) async {
    try {
      final uri = Uri.parse(_getBaseUrl() + path).replace(
        queryParameters: queryParameters,
      );

      final response = await httpClient.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        return json.decode(
          utf8.decode(response.bodyBytes),
        ) as T;
      } else {
        throw ApiException(apiMessage: response.body, httpStatusCode: response.statusCode);
      }
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }

      throw ConnectionException(originalError: e.toString());
    }
  }
}
