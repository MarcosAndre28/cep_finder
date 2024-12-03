import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';
import 'package:cep_finder/src/map/domain/usecases/save_address_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'on_map_repo.mock.dart';

void main() {
  late OnMapRepo repo;
  late ISaveAddressUseCase useCase;

  setUp(() {
    repo = MockOnMapRepo();
    useCase = SaveAddressUseCase(repo);
  });

  const tAddressModel = AddressModel(
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

  group('SaveAddressUseCase', () {
    test('should call saveAddress on the repository when call is executed', () async {
      when(() => repo.saveAddress(addressModel: tAddressModel))
          .thenAnswer((_) async => Future.value());

      await useCase.call(addressModel: tAddressModel);

      verify(() => repo.saveAddress(addressModel: tAddressModel)).called(1);
    });

    test('should throw an exception when saveAddress fails', () async {
      when(() => repo.saveAddress(addressModel: tAddressModel))
          .thenThrow(Exception('Falha ao salvar o endereço'));

      expect(() => useCase.call(addressModel: tAddressModel), throwsA(isA<Exception>()));
      verify(() => repo.saveAddress(addressModel: tAddressModel)).called(1);
    });
  });
}
