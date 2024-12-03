import 'package:cep_finder/src/map/data/datasources/local/map_local_data_source.dart';
import 'package:cep_finder/src/map/data/datasources/remote/map_remote_data_source.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/coordinates_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/data/repos/on_map_repo_impl.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockMapRemoteDataSource extends Mock implements OnMapDataSource {}

class MockMapLocalDataSource extends Mock implements OnMapLocalDataSource {}

void main() {
  late MockMapRemoteDataSource mockMapRemoteDataSource;
  late MockMapLocalDataSource mockMapLocalDataSource;
  late OnMapRepoImpl repo;

  setUp(() {
    mockMapRemoteDataSource = MockMapRemoteDataSource();
    mockMapLocalDataSource = MockMapLocalDataSource();
    repo = OnMapRepoImpl(mockMapRemoteDataSource, mockMapLocalDataSource);
  });

  group('OnMapRepoImpl', () {
    test('should return AddressModel when getAddress is called', () async {
      const remoteResponse = {
        "cep": "85812110",
        "state": "PR",
        "city": "Cascavel",
        "neighborhood": "Centro",
        "street": "Rua Riachuelo",
        "service": "open-cep",
        "location": {
          "type": "Point",
          "coordinates": {
            "longitude": "0",
            "latitude": "0"
          }
        }
      };

      const addressModel = AddressModel(
        zipcode: '85812110',
        state: 'PR',
        city: 'Cascavel',
        service: 'open-cep',
        neighborhood: "Centro",
        street: "Rua Riachuelo",
        location: LocationModel(
          type: 'Point',
          coordinates: CoordinatesModel(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockMapRemoteDataSource.getAddress(cep: '85812110')).thenAnswer((_) async => remoteResponse);
      final result = await repo.getAddress(cep: '85812110');
      expect(result, equals(addressModel));
    });


    test('should throw an exception when getAddress fails', () async {
      when(() => mockMapRemoteDataSource.getAddress(cep: '12345678')).thenThrow(Exception('Erro ao buscar o CEP'));
      expect(() => repo.getAddress(cep: '12345678'), throwsException);
    });

    test('should save address when saveAddress is called', () async {
      const  addressModel = AddressModel(
        zipcode: '12345678',
        state: 'SP',
        city: 'São Paulo',
        service: 'Correios',
        location: LocationModel(
          type: 'Point',
          coordinates: CoordinatesModel(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockMapLocalDataSource.saveAddress(addressModel)).thenAnswer((_) async => {});
      await repo.saveAddress(addressModel: addressModel);
      verify(() => mockMapLocalDataSource.saveAddress(addressModel)).called(1);
    });

    test('should throw an exception when saveAddress fails', () async {
      const  addressModel = AddressModel(
        zipcode: '12345678',
        state: 'SP',
        city: 'São Paulo',
        service: 'Correios',
        location: LocationModel(
          type: 'Point',
          coordinates: CoordinatesModel(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockMapLocalDataSource.saveAddress(addressModel)).thenThrow(Exception('Erro ao salvar o endereço'));
      expect(() => repo.saveAddress(addressModel: addressModel), throwsException);
    });

    test('should return a list of saved AddressModels when getSavedAddress is called', () async {
      final savedAddresses = [
        const AddressModel(
          zipcode: '12345678',
          state: 'SP',
          city: 'São Paulo',
          service: 'Correios',
          location: LocationModel(
            type: 'Point',
            coordinates: CoordinatesModel(longitude: '0', latitude: '0'),
          ),
        ),
      ];
      when(() => mockMapLocalDataSource.getAddress()).thenAnswer((_) async => savedAddresses);
      final result = await repo.getSavedAddress();
      expect(result, equals(savedAddresses));
    });

    test('should throw an exception when getSavedAddress fails', () async {
      when(() => mockMapLocalDataSource.getAddress()).thenThrow(Exception('Erro ao obter endereços salvos'));
      expect(() => repo.getSavedAddress(), throwsException);
    });


    test('should call getAddress on remote data source when getAddress is called', () async {
      final remoteResponse = {
        'cep': '12345678',
        'state': 'SP',
        'city': 'São Paulo',
        'service': 'Correios',
        "neighborhood": "Centro",
        "street": "Rua Riachuelo",
        'location': {'type': 'Point', 'coordinates': {'longitude': '0', 'latitude': '0'}}
      };

      when(() => mockMapRemoteDataSource.getAddress(cep: '12345678')).thenAnswer((_) async => remoteResponse);
      await repo.getAddress(cep: '12345678');
      verify(() => mockMapRemoteDataSource.getAddress(cep: '12345678')).called(1);
    });

    test('should call saveAddress on local data source when saveAddress is called', () async {
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
          coordinates: Coordinates(
            longitude: '-46.654654654654654',
            latitude: '-23.654654654654654',
          ),
        ),
      );

      when(() => mockMapLocalDataSource.saveAddress(addressModel)).thenAnswer((_) async {});
      await repo.saveAddress(addressModel: addressModel);
      verify(() => mockMapLocalDataSource.saveAddress(addressModel)).called(1);
    });

    test('should call getAddress on local data source when getSavedAddress is called', () async {
      const  savedAddresses = [
      AddressModel(
        zipcode: '12345',
        city: 'São Paulo',
        state: 'SP',
        complement: 'Complemento',
        saved: true,
        number: 123,
        neighborhood: 'Centro',
        street: 'Rua da Saudade',
        location: LocationModel(
          coordinates: Coordinates(
            longitude: '-46.654654654654654',
            latitude: '-23.654654654654654',
          ),
        ),
      )
      ];

      when(() => mockMapLocalDataSource.getAddress()).thenAnswer((_) async => savedAddresses);

      await repo.getSavedAddress();

      verify(() => mockMapLocalDataSource.getAddress()).called(1);
    });
  });
}
