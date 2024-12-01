import 'package:cep_finder/core/usecase/usecase.dart';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

class IGetAddressUseCase extends UseCaseWithParams<void, String> {
  const IGetAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  ResultFuture<AddressModel> call(String params) async => _repo.getAddress(
        cep: params,
      );
}
