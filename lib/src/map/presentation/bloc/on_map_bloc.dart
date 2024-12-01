import 'package:bloc/bloc.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/usecases/get_address_usecase.dart';
import 'package:cep_finder/src/map/domain/usecases/get_saved_address_usecase.dart';
import 'package:cep_finder/src/map/domain/usecases/save_address_usecase.dart';
import 'package:equatable/equatable.dart';

part 'on_map_event.dart';

part 'on_map_state.dart';

class OnMapBloc extends Bloc<OnMapEvent, OnMapState> {
  OnMapBloc({
    required IGetAddressUseCase getAddress,
    required IGetSavedAddressUseCase getSavedAddress,
    required ISaveAddressUseCase saveAddress,
  })  : _getAddressUseCase = getAddress,
        _getSavedAddressUseCase = getSavedAddress,
        _saveAddressUseCase = saveAddress,
        super(const MapInitial()) {
    on<GetCepDataEvent>(_getCepDataHandler);
    on<GetSavedAddressEvent>(_getSavedAddressHandler);
    on<SaveAddressEvent>(_saveAddressHandler);
  }

  final IGetAddressUseCase _getAddressUseCase;
  final IGetSavedAddressUseCase _getSavedAddressUseCase;
  final ISaveAddressUseCase _saveAddressUseCase;

  Future<void> _getCepDataHandler(
    GetCepDataEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    final result = await _getAddressUseCase(event.cep);
    result.fold(
      (failure) => emit(MapError(failure.message)),
      (address) => emit(MapCepDataState(addressModel: address)),
    );
  }

  Future<void> _getSavedAddressHandler(
    GetSavedAddressEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    final result = await _getSavedAddressUseCase();
    result.fold(
      (failure) => emit(MapError(failure.message)),
      (address) => emit(GetSavedAddressState(address)),
    );
  }

   Future<void> _saveAddressHandler(
    SaveAddressEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    final result = await _saveAddressUseCase(event.address);
    result.fold(
      (failure) => emit(MapError(failure.message)),
      (address) => emit(const SaveAddressState()),
    );
  }
}
