import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

abstract class IGetSavedAddressUseCase {
  Future<List<AddressModel>> call();
}

class GetSavedAddressUseCase implements IGetSavedAddressUseCase {
  GetSavedAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  Future<List<AddressModel>> call() => _repo.getSavedAddress();
}