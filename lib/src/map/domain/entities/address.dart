import 'package:cep_finder/src/map/domain/entities/location_addres.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.cep,
    required this.state,
    required this.city,
    required this.location,
     this.service,
     this.neighborhood,
     this.street,
     this.number,
     this.complement,
  });

  const Address.empty()
      : this(
          cep: '',
          state: '',
          city: '',
          neighborhood: '',
          street: '',
          service: '',
          location: const LocationAddress.empty(),
        );

  final String cep;
  final String state;
  final String city;
  final LocationAddress location;
  final String? service;
  final String? neighborhood;
  final String? street;
  final int? number;
  final String? complement;

  @override
  List<Object?> get props => [cep, state, city];

  @override
  String toString() {
    return 'Address(cep: $cep, state: $state, city: $city, '
        'neighborhood: $neighborhood, street: $street, '
        'service: $service, location: $location)';
  }
}
