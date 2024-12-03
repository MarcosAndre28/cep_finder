import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:cep_finder/src/map/domain/repos/on_map_repo.dart';
import 'package:cep_finder/src/map/domain/usecases/get_address_usecase.dart';
import 'on_map_repo.mock.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late OnMapRepo repo;
  late IGetAddressUseCase useCase;

  setUp(() {
    repo = MockOnMapRepo();
    useCase = GetAddressUseCase(repo);
  });


  test('should call the [OnMapRepo.getAddress] '
      'and return the right data', ()  async {

    const  mockAddress =  AddressModel(
      zipcode: '85812110',
      state: 'PR',
      city: 'Cascavel',
      neighborhood: 'Cascavel',
      street: 'Rua Riachuelo',
      service: 'open-cep',
      location: LocationModel(
        type: 'Point',
        coordinates: Coordinates(
          longitude: '-53.44961748381532',
          latitude: '-24.954089913184347',
        ),
      ),
    );

    when(() => repo.getAddress(cep: '85812110')).thenAnswer((_) async => mockAddress);

    final result = await useCase.call(zipcode: '85812110');

    expect(result, isA<AddressModel>());
    expect(result.zipcode, mockAddress.zipcode);
    expect(result.city, mockAddress.city);
    expect(result.state, mockAddress.state);
    expect(result.location.coordinates.longitude, mockAddress.location.coordinates.longitude);
    expect(result.location.coordinates.latitude, mockAddress.location.coordinates.latitude);

    verify(() => repo.getAddress(cep: '85812110')).called(1);

  });
}