import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';

abstract class OnMapRepo{
  const OnMapRepo();
  Future<AddressModel> getAddress({required String cep});
  Future<void> saveAddress({required AddressModel addressModel});
  Future<List<AddressModel>> getSavedAddress();
}
