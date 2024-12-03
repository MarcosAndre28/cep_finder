import 'dart:convert';

import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.zipcode,
    required super.state,
    required super.city,
    required super.location,
    super.service,
    super.neighborhood,
    super.street,
    super.number,
    super.complement,
    super.saved,
  });

  const AddressModel.empty()
      : super(
          zipcode: '',
          state: '',
          city: '',
          neighborhood: '',
          street: '',
          service: '',
          number: 0,
          complement: '',
          saved: false,
          location: const LocationModel.empty(),
        );

  AddressModel.fromMap(DataMap map)
      : super(
          zipcode: map['cep'] as String,
          state: map['state'] as String,
          city: map['city'] as String,
          neighborhood: map['neighborhood'] as String?,
          street: map['street'] as String?,
          service: map['service'] as String?,
          number: map['number'] as int?,
          complement: map['complement'] as String?,
          saved: map['saved'] as bool?,
          location: LocationModel.fromMap(map['location'] as DataMap),
        );

  DataMap toMap() => {
        'cep': zipcode,
        'state': state,
        'city': city,
        'neighborhood': neighborhood,
        'street': street,
        'service': service,
        'location': [location],
      };

  AddressModel copyWith({
    String? zipcode,
    String? state,
    String? city,
    String? neighborhood,
    String? street,
    String? service,
    LocationModel? location,
    int? number,
    bool? saved,
    String? complement,
  }) {
    return AddressModel(
      zipcode: zipcode ?? this.zipcode,
      state: state ?? this.state,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
      service: service ?? this.service,
      location: location ?? this.location,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      saved: saved ?? this.saved,
    );
  }

  String toJson() {
    return json.encode(toMap());
  }
}
