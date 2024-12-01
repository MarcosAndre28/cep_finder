import 'package:cep_finder/core/usecase/usecase.dart';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

class ISaveAddressUseCase extends UseCaseWithParams<void, AddressModel> {
  const ISaveAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  ResultFuture<void> call(AddressModel params) async => _repo.saveAddress(
        addressModel: params,
      );
}
