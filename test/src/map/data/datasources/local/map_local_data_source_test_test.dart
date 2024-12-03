import 'package:cep_finder/src/map/data/datasources/local/map_local_data_source.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late OnMapLocalDataSourceImpl dataSource;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = OnMapLocalDataSourceImpl(fakeFirestore);
  });

  group('OnMapLocalDataSourceImpl', () {
    test('should save address to Firestore', () async {
      const addressModel = AddressModel(
        zipcode: '12345',
        city: 'São Paulo',
        state: 'SP',
        complement: 'Complemento',
        saved: true,
        number: 123,
        neighborhood: 'Centro',
        street: 'Rua da Saudade',
        location: LocationModel(
          coordinates: Coordinates(longitude: '-46.654654654654654', latitude: '-23.654654654654654'),
        ),
      );

      await dataSource.saveAddress(addressModel);

      final snapshot = await fakeFirestore.collection('addresses').get();
      expect(snapshot.docs.length, 1);
      final docData = snapshot.docs.first.data();
      expect(docData['cep'], '12345');
      expect(docData['city'], 'São Paulo');
      expect(docData['state'], 'SP');
    });

    test('should return a list of AddressModels when getAddress is called', () async {
      const addressModel = AddressModel(
        zipcode: '85812110',
        state: 'PR',
        city: 'Cascavel',
        neighborhood: 'Centro',
        street: 'Rua Riachuelo',
        service: 'open-cep',
        location: LocationModel(
          coordinates: Coordinates(longitude: '0', latitude: '0'),
        ),
      );

      await dataSource.saveAddress(addressModel);

      final result = await dataSource.getAddress();

      expect(result, isA<List<AddressModel>>());
      expect(result.first.zipcode, '85812110');
      expect(result.first.city, 'Cascavel');
      expect(result.first.state, 'PR');
    });
  });
}
