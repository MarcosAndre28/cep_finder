import 'dart:convert';

import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.cep,
    required super.state,
    required super.city,
    required super.service,
    required super.location,
    super.neighborhood,
    super.street,
    super.number,
    super.complement,
  });

  const AddressModel.empty()
      : super(
          cep: '',
          state: '',
          city: '',
          neighborhood: '',
          street: '',
          service: '',
          number: 0,
          complement: '',
          location: const LocationModel.empty(),
        );

  AddressModel.fromMap(DataMap map)
      : super(
          cep: map['cep'] as String,
          state: map['state'] as String,
          city: map['city'] as String,
          neighborhood: map['neighborhood'] as String?,
          street: map['street'] as String?,
          service: map['service'] as String?,
          location: LocationModel.fromMap(map['location'] as DataMap),
        );

  DataMap toMap() => {
        'cep': cep,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'service': service,
        'location': [location],
      };

  String toJson() {
    return json.encode(toMap());
  }
}
