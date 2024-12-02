import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

abstract class ISaveAddressUseCase {
  Future<void> call({
    required AddressModel addressModel,
  });
}

class SaveAddressUseCase implements ISaveAddressUseCase {
  SaveAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  Future<void> call({
    required AddressModel addressModel,
  }) =>
      _repo.saveAddress(addressModel: addressModel);
}
