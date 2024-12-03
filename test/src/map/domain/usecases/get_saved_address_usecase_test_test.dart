import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';
import 'package:cep_finder/src/map/domain/usecases/get_saved_address_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'on_map_repo.mock.dart';

void main() {
  late OnMapRepo repo;
  late IGetSavedAddressUseCase useCase;

  setUp(() {
    repo = MockOnMapRepo();
    useCase = GetSavedAddressUseCase(repo);
  });

  group('GetSavedAddressUseCase', () {
    const List<AddressModel> tAddressList = [
      AddressModel(
          zipcode: '12345', state: 'SP', city: 'São Paulo', service: 'Delivery', location: LocationModel.empty()),
      AddressModel(
          zipcode: '67890', state: 'RJ', city: 'Rio de Janeiro', service: 'Pickup', location: LocationModel.empty()),
    ];

    test('should return a list of AddressModel when call is successful', () async {
      when(() => repo.getSavedAddress()).thenAnswer((_) async => tAddressList);
      final result = await useCase.call();
      expect(result, equals(tAddressList));
      verify(() => repo.getSavedAddress()).called(1);
    });

    test('should throw an exception when call fails', () async {
      when(() => repo.getSavedAddress()).thenThrow(Exception('Falha ao buscar endereços salvos'));
      expect(() => useCase.call(), throwsA(isA<Exception>()));
      verify(() => repo.getSavedAddress()).called(1);
    });
  });
}
