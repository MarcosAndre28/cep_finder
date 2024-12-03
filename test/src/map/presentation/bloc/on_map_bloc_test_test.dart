import 'package:cep_finder/core/utils/constants.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/data/model/location_model.dart';
import 'package:cep_finder/src/map/domain/entities/coordinates.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'get_address_usecase.mock.dart';
import 'get_saved_address_usecase.mock.dart';
import 'saved_address_usecase.mock.dart';

void main() {
  late MockGetAddressUseCase mockGetAddressUseCase;
  late MockGetSavedAddressUseCase mockGetSavedAddressUseCase;
  late MockSaveAddressUseCase mockSaveAddressUseCase;
  late OnMapBloc bloc;

  setUp(() {
    mockGetAddressUseCase = MockGetAddressUseCase();
    mockGetSavedAddressUseCase = MockGetSavedAddressUseCase();
    mockSaveAddressUseCase = MockSaveAddressUseCase();
    bloc = OnMapBloc(
      getAddress: mockGetAddressUseCase,
      getSavedAddress: mockGetSavedAddressUseCase,
      saveAddress: mockSaveAddressUseCase,
    );
  });

  group('OnMapBloc', () {
    test('emits MapCepDataState on success when GetCepDataEvent is added', () async {
      const addressModel = AddressModel(
        zipcode: '12345678',
        state: 'SP',
        city: 'São Paulo',
        service: 'Correios',
        location: LocationModel(
          type: 'Point',
          coordinates: Coordinates(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockGetAddressUseCase.call(zipcode: '12345678')).thenAnswer((_) async => addressModel);

      bloc.add(const GetCepDataEvent('12345678'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const MapCepDataState(addressModel: addressModel),
        ]),
      );
    });

    test('emits MapErrorState on failure when GetCepDataEvent is added', () async {
      when(() => mockGetAddressUseCase.call(zipcode: '12345678')).thenThrow(Exception('Erro ao buscar CEP'));

      bloc.add(const GetCepDataEvent('12345678'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const MapErrorState(Constants.message),
        ]),
      );
    });

    test('emits GetSavedAddressState on success when GetSavedAddressEvent is added', () async {
      const savedAddress = [
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
        ),
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

      when(() => mockGetSavedAddressUseCase.call()).thenAnswer((_) async => savedAddress);

      bloc.add(const GetSavedAddressEvent());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const GetSavedAddressState(savedAddress),
        ]),
      );
    });

    test('emits MapErrorState on failure when GetSavedAddressEvent is added', () async {
      when(() => mockGetSavedAddressUseCase.call()).thenThrow(Exception('Erro ao buscar endereço salvo'));

      bloc.add(const GetSavedAddressEvent());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const MapErrorState('Erro ao buscar endereço salvo'),
        ]),
      );
    });

    test('emits SaveAddressState on success when SaveAddressEvent is added', () async {
      const  addressToSave = AddressModel(
        zipcode: '12345678',
        state: 'SP',
        city: 'São Paulo',
        service: 'Correios',
        location: LocationModel(
          type: 'Point',
          coordinates: Coordinates(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockSaveAddressUseCase.call(addressModel: addressToSave)).thenAnswer((_) async {});

      bloc.add(const SaveAddressEvent(addressToSave));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const SaveAddressState(),
        ]),
      );
    });

    test('emits MapErrorState on failure when SaveAddressEvent is added', () async {
      const  addressToSave = AddressModel(
        zipcode: '12345678',
        state: 'SP',
        city: 'São Paulo',
        service: 'Correios',
        location: LocationModel(
          type: 'Point',
          coordinates: Coordinates(longitude: '0', latitude: '0'),
        ),
      );

      when(() => mockSaveAddressUseCase.call(addressModel: addressToSave)).thenThrow(Exception('Erro ao salvar endereço'));

      bloc.add(const SaveAddressEvent(addressToSave));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const MapLoadingState(),
          const MapErrorState('Erro ao salvar endereço'),
        ]),
      );
    });



  });
}
