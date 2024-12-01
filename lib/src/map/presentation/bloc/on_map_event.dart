part of 'on_map_bloc.dart';

sealed class OnMapEvent extends Equatable {
  const OnMapEvent();

  @override
  List<Object> get props => [];
}

class GetCepDataEvent extends OnMapEvent {
  const GetCepDataEvent(this.cep);

  final String cep;

  @override
  List<String> get props => [cep];
}

class GetSavedAddressEvent extends OnMapEvent {
  const GetSavedAddressEvent();
}

class SaveAddressEvent extends OnMapEvent {
  const SaveAddressEvent(this.address);

  final AddressModel address;

  @override
  List<Object> get props => [address];
}
