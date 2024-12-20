import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class OnMapLocalDataSource {
  const OnMapLocalDataSource();

  Future<void> saveAddress(AddressModel address);
  Future<List<AddressModel>> getAddress();
}

const kEndpoint = 'v2/';

class OnMapLocalDataSourceImpl extends OnMapLocalDataSource {
  const OnMapLocalDataSourceImpl(this._fireStore);

  final FirebaseFirestore _fireStore;

  @override
  Future<void> saveAddress(AddressModel address) async {
    final  addressMap = {
      'cep': address.zipcode,
      'state': address.state,
      'city': address.city,
      'neighborhood': address.neighborhood,
      'street': address.street,
      'number': address.number,
      'complement': address.complement,
      'saved': address.saved,
      'location': {
        'coordinates': {
          'longitude': address.location.coordinates.longitude,
          'latitude': address.location.coordinates.latitude,
        },
      },
    };
    await _fireStore.collection('addresses').add(addressMap);
  }

  @override
  Future<List<AddressModel>> getAddress() async {
    final querySnapshot = await _fireStore.collection('addresses').get();
    return querySnapshot.docs
        .map((doc) => AddressModel.fromMap(doc.data()))
        .toList();
  }
}
