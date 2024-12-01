import 'package:cep_finder/core/errors/exceptions.dart';
import 'package:cep_finder/core/services/http_service.dart';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';

abstract class OnMapDataSource {
  const OnMapDataSource();

  Future<AddressModel> getAddress({
    required String cep,
  });
}

const kEndpoint = 'v2/';

class OnMapDataSourceImpl extends OnMapDataSource {
  const OnMapDataSourceImpl(this._httpService);

  final IHttpService _httpService;

  @override
  Future<AddressModel> getAddress({
    required String cep,
  }) async {
    try {
      final response = await _httpService.get('$kEndpoint$cep');
      final address = AddressModel.fromMap(response.data as DataMap);
      return address;
    }  catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
