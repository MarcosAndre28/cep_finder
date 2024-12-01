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

  @override
  List<Object?> get props => [type, coordinates];

  @override
  String toString() {
    return 'LocationAddress(type: $type, coordinates: $coordinates)';
  }
}
