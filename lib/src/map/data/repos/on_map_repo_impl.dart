import 'package:cep_finder/core/errors/exceptions.dart';
import 'package:cep_finder/core/errors/failures.dart';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/datasources/local/map_local_data_source.dart';
import 'package:cep_finder/src/map/data/datasources/remote/map_remote_data_source.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';
import 'package:dartz/dartz.dart';

class OnMapRepoImpl implements OnMapRepo {
  const OnMapRepoImpl(this._mapRemoteDataSource, this._mapLocalDataSource);

  final OnMapDataSource _mapRemoteDataSource;
  final OnMapLocalDataSource _mapLocalDataSource ;

  @override
  ResultFuture<AddressModel> getAddress({required String cep}) async {
    try {
      final result = await _mapRemoteDataSource.getAddress(cep: cep);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> saveAddress({required AddressModel addressModel}) async {
    try {
      await _mapLocalDataSource.saveAddress(addressModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<AddressModel>> getSavedAddress() async {
    try {
      final result = await _mapLocalDataSource.getAddress();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
