import 'package:cep_finder/core/services/http_service.dart';

abstract class OnMapDataSource {
  const OnMapDataSource();

  Future<dynamic> getAddress({
    required String cep,
  });
}

const kEndpoint = 'v2/';

class OnMapDataSourceImpl extends OnMapDataSource {
  const OnMapDataSourceImpl(this._httpService);

  final IHttpService _httpService;

  @override
  Future<dynamic> getAddress({
    required String cep,
  }) async {
    return await _httpService.get(path: '$kEndpoint$cep');
  }
}
