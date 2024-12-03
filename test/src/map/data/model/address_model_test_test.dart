import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/coordinates_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/address.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:cep_finder/src/map/domain/entities/location_addres.dart';
import 'package:test/test.dart';

void main() {
  const tAddressModel = AddressModel.empty();
  const tLocationModel = LocationModel.empty();
  const tCoordinatesModel = CoordinatesModel.empty();

  group('Entities', () {
    test(
      'Should be a subclass of  [Address] entity',
          () => expect(
        tAddressModel,
        isA<Address>(),
      ),
    );

    test(
      'Should be a subclass of  [LocalUser] entity',
          () => expect(
        tLocationModel,
        isA<LocationAddress>(),
      ),
    );

    test(
      'Should be a subclass of  [LocalUser] entity',
          () => expect(
        tCoordinatesModel,
        isA<Coordinates>(),
      ),
    );
  });

}