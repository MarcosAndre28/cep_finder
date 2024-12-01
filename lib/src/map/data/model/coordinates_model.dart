import 'dart:convert';
import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({
    required super.longitude,
    required super.latitude,
  });

  const CoordinatesModel.empty() : this(
    longitude: '',
    latitude: '',
  );

  CoordinatesModel.fromMap(DataMap map) : super(
    longitude: map['longitude'] as String,
    latitude: map['latitude'] as String,
  );

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
