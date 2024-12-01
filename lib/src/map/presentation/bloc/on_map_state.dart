part of 'on_map_bloc.dart';

sealed class OnMapState extends Equatable {
  const OnMapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends OnMapState {
  const MapInitial();
}

final class MapLoadingState extends OnMapState {
  const MapLoadingState();
}

final class SaveAddressState extends OnMapState {
  const SaveAddressState();
}

final class GetSavedAddressState extends OnMapState {
  const GetSavedAddressState(this.addressModelList);

  final List<AddressModel> addressModelList;

  @override
  List<AddressModel> get props => addressModelList;
}

class MapCepDataState extends OnMapState {
  const MapCepDataState({required this.addressModel});

  final AddressModel addressModel;

  @override
  List<AddressModel> get props => [addressModel];
}

class MapError extends OnMapState {
  const MapError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
