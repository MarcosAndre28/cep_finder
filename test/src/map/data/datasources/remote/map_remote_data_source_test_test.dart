import 'package:cep_finder/src/map/data/datasources/remote/map_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'http_service.mock.dart';



void main() {
    late MockHttpService mockHttpService;
    late OnMapDataSourceImpl dataSource;

    setUp(() {
        mockHttpService = MockHttpService();
        dataSource = OnMapDataSourceImpl(mockHttpService);
    });

    group('OnMapDataSourceImpl', () {
        const cep = '85812110';
        const mockResponse = {
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

        test('should call getAddress on IHttpService and return data', () async {
            when(() => mockHttpService.get(path: 'v2/$cep')).thenAnswer(
                    (_) async => mockResponse,
            );
            final result = await dataSource.getAddress(cep: cep);
            verify(() => mockHttpService.get(path: 'v2/$cep')).called(1);
            expect(result, equals(mockResponse));
        });

        test('should throw an error if the HTTP request fails', () async {
            when(() => mockHttpService.get(path: 'v2/$cep')).thenThrow(Exception('Erro ao buscar endereço'));
            expect(() => dataSource.getAddress(cep: cep), throwsA(isA<Exception>()));
        });
    });
}
