import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates({
    required this.longitude,
    required this.latitude,
  });

  const Coordinates.empty() : this(longitude: '', latitude: '');

  final String longitude;
  final String latitude;

  @override
  List<Object?> get props => [latitude, longitude];


  factory Coordinates.fromMap(DataMap map) => Coordinates(
        longitude: map['longitude'] as String,
        latitude: map['latitude'] as String,
      );

  @override
  String toString() {
    return 'Coordinates(longitude: $longitude, latitude: $latitude)';
  }
}
