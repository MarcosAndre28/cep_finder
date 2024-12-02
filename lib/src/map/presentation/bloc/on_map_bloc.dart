import 'package:bloc/bloc.dart';
import 'package:cep_finder/core/errors/bloc_safe_run.dart';
import 'package:cep_finder/core/utils/constants.dart';
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
    onSafe<GetCepDataEvent>(_getCepDataHandler, errorState: (message) => const MapErrorState(Constants.message));
    onSafe<GetSavedAddressEvent>(_getSavedAddressHandler, errorState: (message) => MapErrorState(message));
    onSafe<SaveAddressEvent>(_saveAddressHandler, errorState: (message) => MapErrorState(message));
  }

  final IGetAddressUseCase _getAddressUseCase;
  final IGetSavedAddressUseCase _getSavedAddressUseCase;
  final ISaveAddressUseCase _saveAddressUseCase;

  Future<void> _getCepDataHandler(
    GetCepDataEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    final result = await _getAddressUseCase(zipcode: event.cep);
    emit(
      MapCepDataState(addressModel: result),
    );
  }

  Future<void> _getSavedAddressHandler(
    GetSavedAddressEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    final result = await _getSavedAddressUseCase();
    emit(GetSavedAddressState(result));
  }

  Future<void> _saveAddressHandler(
    SaveAddressEvent event,
    Emitter<OnMapState> emit,
  ) async {
    emit(const MapLoadingState());
    await _saveAddressUseCase(addressModel: event.address);
    emit(const SaveAddressState());
  }
}
