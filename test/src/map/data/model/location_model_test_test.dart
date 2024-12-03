import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/location_addres.dart';
import 'package:test/test.dart';

void main() {
    const tLocationModel = LocationModel.empty();
    test(
        'Should be a subclass of  [LocalUser] entity',
            () => expect(
            tLocationModel,
            isA<LocationAddress>(),
        ),
    );
}