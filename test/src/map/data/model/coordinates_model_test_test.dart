import 'package:cep_finder/src/map/data/model/coordinates_model.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:test/test.dart';

void main() {
  const tCoordinatesModel = CoordinatesModel.empty();

  test(
    'Should be a subclass of  [LocalUser] entity',
        () => expect(
      tCoordinatesModel,
      isA<Coordinates>(),
    ),
  );
}