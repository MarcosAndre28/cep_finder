import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/domain/entities/address.dart';
import 'package:test/test.dart';

void main() {
  const tAddressModel = AddressModel.empty();


  test(
    'Should be a subclass of  [Address] entity',
        () => expect(
      tAddressModel,
      isA<Address>(),
    ),
  );

}