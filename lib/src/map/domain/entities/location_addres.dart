import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:equatable/equatable.dart';

class LocationAddress extends Equatable {
  const LocationAddress({

    required this.coordinates,
     this.type,
  });

  const LocationAddress.empty()
      : this(
          type: '',
          coordinates: const Coordinates.empty(),
        );

  final String? type;
  final Coordinates coordinates;

  factory LocationAddress.fromMap(DataMap map) {
    return LocationAddress(
      type: map['type'] as String?,
      coordinates: Coordinates.fromMap(map['coordinates'] as DataMap),
    );
  }

  @override
  List<Object?> get props => [type, coordinates];

  @override
  String toString() {
    return 'LocationAddress(type: $type, coordinates: $coordinates)';
  }
}
