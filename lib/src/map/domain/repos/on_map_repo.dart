import 'package:cep_finder/core/utils/typedefs.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';

abstract class OnMapRepo{
  const OnMapRepo();
  ResultFuture<AddressModel> getAddress({required String cep});
  ResultFuture<void> saveAddress({required AddressModel addressModel});
  ResultFuture<List<AddressModel>> getSavedAddress();
}
