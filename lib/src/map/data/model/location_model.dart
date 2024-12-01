import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/coordinates_model.dart';
import 'package:cep_finder/src/map/domain/entities/location_addres.dart';

class LocationModel extends LocationAddress {
  const LocationModel({
    required super.type,
    required super.coordinates,
  });

  const LocationModel.empty()
      : this(
          type: '',
          coordinates: const CoordinatesModel.empty(),
        );

  LocationModel.fromMap(DataMap map)
      : super(
          type: map['type'] as String?,
          coordinates: CoordinatesModel.fromMap(map['coordinates'] as DataMap),
        );

  DataMap toMap() => {
        'type': type,
        'coordinates': CoordinatesModel(
          longitude: coordinates.longitude,
          latitude: coordinates.latitude,
        ).toMap(),
      };
}
