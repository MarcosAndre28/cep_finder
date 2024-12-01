import 'package:cep_finder/core/usecase/usecase.dart';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

class IGetSavedAddressUseCase extends UseCaseWithoutParams<List<AddressModel>> {
  const IGetSavedAddressUseCase(this._repo);

  final OnMapRepo _repo;

  @override
  ResultFuture<List<AddressModel>> call() async => _repo.getSavedAddress();
}
