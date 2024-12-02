import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

abstract class IGetAddressUseCase {
  Future<AddressModel> call({
    required String zipcode,
  });
}

class GetAddressUseCase implements IGetAddressUseCase {
  GetAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  Future<AddressModel> call({
    required String zipcode,
  }) =>
      _repo.getAddress(cep: zipcode);
}
