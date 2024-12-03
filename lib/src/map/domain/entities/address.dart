import 'package:cep_finder/src/map/domain/entities/location_addres.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  const Address({
    required this.zipcode,
    required this.state,
    required this.city,
    required this.location,
    this.service,
    this.neighborhood,
    this.street,
    this.number,
    this.complement,
    this.saved,
  });

  const Address.empty()
      : this(
          zipcode: '',
          state: '',
          city: '',
          neighborhood: '',
          street: '',
          service: '',
          saved: false,
          location: const LocationAddress.empty(),
        );

  final String zipcode;
  final String state;
  final String city;
  final LocationAddress location;
  final String? service;
  final String? neighborhood;
  final String? street;
  final int? number;
  final String? complement;
  final bool? saved;


  @override
  List<Object?> get props => [zipcode, state, city, neighborhood, street, service, location];

  @override
  String toString() {
    return 'Address(cep: $zipcode, state: $state, city: $city, '
        'neighborhood: $neighborhood, street: $street, '
        'service: $service, location: $location)';
  }
}
