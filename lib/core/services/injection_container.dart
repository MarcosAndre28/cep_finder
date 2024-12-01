import 'package:cep_finder/core/services/http_service.dart';
import 'package:cep_finder/src/map/data/datasources/local/map_local_data_source.dart';
import 'package:cep_finder/src/map/data/datasources/remote/map_remote_data_source.dart';
import 'package:cep_finder/src/map/data/repos/on_map_repo_impl.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';
import 'package:cep_finder/src/map/domain/usecases/get_address_usecase.dart';
import 'package:cep_finder/src/map/domain/usecases/get_saved_address_usecase.dart';
import 'package:cep_finder/src/map/domain/usecases/save_address_usecase.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final fireStore =  FirebaseFirestore.instance;
  sl
    ..registerLazySingleton<IHttpService>(HttpServiceImpl.new)
    ..registerLazySingleton<OnMapDataSource>(() => OnMapDataSourceImpl(sl()))
    ..registerLazySingleton<OnMapLocalDataSource>(
      () => OnMapLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<OnMapRepo>(() => OnMapRepoImpl(sl(), sl()))
    ..registerLazySingleton(() => IGetAddressUseCase(sl()))
    ..registerLazySingleton(() => ISaveAddressUseCase(sl()))
    ..registerLazySingleton(() => IGetSavedAddressUseCase(sl()))
    ..registerFactory(
      () => OnMapBloc(
        getAddress: sl(),
        getSavedAddress: sl(),
        saveAddress: sl(),
      ),
    )
    ..registerLazySingleton(() => fireStore);
}
