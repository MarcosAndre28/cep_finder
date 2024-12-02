import 'package:cep_finder/src/map/data/datasources/local/map_local_data_source.dart';
import 'package:cep_finder/src/map/data/datasources/remote/map_remote_data_source.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';

class OnMapRepoImpl implements OnMapRepo {
  const OnMapRepoImpl(this._mapRemoteDataSource, this._mapLocalDataSource);

  final OnMapDataSource _mapRemoteDataSource;
  final OnMapLocalDataSource _mapLocalDataSource;

  @override
  Future<AddressModel> getAddress({required String cep}) async {
    final result = await _mapRemoteDataSource.getAddress(cep: cep);
    return AddressModel.fromMap(result);
  }

  @override
  Future<void> saveAddress({required AddressModel addressModel}) async {
    return await _mapLocalDataSource.saveAddress(addressModel);
  }

  @override
  Future<List<AddressModel>> getSavedAddress() async {
    final result = await _mapLocalDataSource.getAddress();
    return result;
  }
}
