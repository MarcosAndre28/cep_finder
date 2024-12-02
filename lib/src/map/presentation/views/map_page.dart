import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cep_finder/core/common/widgets/bottom_navigation_bar.dart';
import 'package:cep_finder/core/common/widgets/default_button.dart';
import 'package:cep_finder/core/common/widgets/default_text_form_field.dart';
import 'package:cep_finder/core/extensions/context_extension.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/fonts.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cep_finder/src/map/presentation/widgets/list_search_items_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  static const routeName = 'MapPage';

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController cepController = TextEditingController();
  final FocusNode cepFocusNode = FocusNode();
  GoogleMapController? _controller;
  Location location = Location();
  bool isShowSearchIcon = false;
  bool isShowHistory = false;
  Set<Marker> markers = {};
  List<AddressModel> addressList = [];

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  void dispose() {
    cepController.dispose();
    cepFocusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onMapBloc = context.watch<OnMapBloc>().state;
    return Scaffold(
      body: BlocListener<OnMapBloc, OnMapState>(
        listener: (context, state) {
          if (state is MapCepDataState) {
            setState(() {
              isShowHistory = false;
            });
            _addMarker(state.addressModel);
          }
          if (state is GetSavedAddressState) {
            if (state.addressModelList.isNotEmpty) {
              setState(() {
                addressList = state.addressModelList;
              });
            }
          }
        },
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 12,
              ),
              onMapCreated: _onMapCreated,
              markers: markers,
              compassEnabled: false,
              zoomControlsEnabled: false,
            ),
            if (isShowHistory && addressList.isNotEmpty)
              onMapBloc is MapLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colours.tealBlue,
                      ),
                    )
                  : Container(
                      height: context.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: context.height * 0.12,
                        ),
                        child: ListView.builder(
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            final addressData = addressList[index];
                            return ListSearchItemsMapWidget(
                              zipCode: addressData.zipcode,
                              street: addressData.street ?? '',
                              city: addressData.city,
                              onTap: (cep) {
                                cepFocusNode.unfocus();
                                _addMarker(addressData);
                              },
                            );
                          },
                        ),
                      ),
                    ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.height * 0.06,
                  horizontal: context.width * 0.05,
                ),
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: Form(
                    key: _formKey,
                    child: DefaultTextFormField(
                      controller: cepController,
                      focusNode: cepFocusNode,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Buscar',
                      hintStyle: const TextStyle(
                        color: Colours.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textStyle: const TextStyle(
                        color: Colours.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colours.grey,
                        size: 30,
                      ),
                      suffixIcon: cepController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowSearchIcon = false;
                                  isShowHistory = false;
                                  cepController.clear();
                                  cepFocusNode.unfocus();
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                              ),
                            )
                          : null,
                      keyboardType: TextInputType.number,
                      onTap: () {
                        setState(() {
                          isShowSearchIcon = true;
                          isShowHistory = true;
                        });
                      },
                      onChanged: (text) {
                        setState(() {
                          isShowHistory = text.isNotEmpty;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O campo não pode estar vazio.';
                        }
                        if (value.replaceAll(RegExp(r'\D'), '').length != 8) {
                          return 'CEP deve ter 8 números.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isShowSearchIcon
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              shape: const CircleBorder(),
              elevation: 10,
              child: const Icon(
                Icons.search,
                color: Colours.white,
                size: 30,
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  cepFocusNode.unfocus();
                  getCepData(cepController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Por favor, insira um CEP valido.',
                      ),
                    ),
                  );
                }
              },
            )
          : null,
      bottomNavigationBar: const BottomNavigationBarWidget(
        currentIndex: 0,
      ),
    );
  }

  void getCepData(String cep) {
    context.read<OnMapBloc>().add(GetCepDataEvent(cep));
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  void _addMarker(AddressModel location) {
    final latitude = double.parse(location.location.coordinates.latitude);
    final longitude = double.parse(location.location.coordinates.longitude);

    final position = LatLng(latitude, longitude);

    final marker = Marker(
      markerId: MarkerId(location.zipcode),
      position: position,
      infoWindow: InfoWindow(
        title: location.street ?? '',
        snippet: '${location.city}, ${location.state}',
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: context.height * 0.28,
                    width: context.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Align(
                            child: SizedBox(
                              width: 32,
                              height: 4,
                              child: Divider(
                                color: Colours.cadet,
                                thickness: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            location.zipcode,
                            style: TextStyle(
                              fontSize: context.height * 0.026,
                              fontFamily: Fonts.roboto,
                              fontWeight: FontWeight.w500,
                              color: Colours.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            location.street != null && location.street!.isNotEmpty
                                ? '${location.street} - ${location.city}, ${location.state}'
                                : '${location.city}, ${location.state}',
                            style: TextStyle(
                              fontSize: context.height * 0.018,
                              fontFamily: Fonts.roboto,
                              fontWeight: FontWeight.w500,
                              color: Colours.quartz,
                            ),
                          ),
                          const SizedBox(height: 15),
                          DefaultButton(
                            onPressed: () {
                              context.go('/revision', extra: location);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Salvar endereço',
                              style: TextStyle(
                                fontSize: context.height * 0.020,
                                fontFamily: Fonts.roboto,
                                fontWeight: FontWeight.w600,
                                color: Colours.antiFlashWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    setState(() {
      markers.add(marker);
    });

    _onCameraMove(latitude: latitude, longitude: longitude);
  }

  void _onCameraMove({required double latitude, required double longitude}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 15,
            ),
          ),
        );
        setState(() {
          isShowHistory = false;
        });
      },
    );
  }

  void getHistory() {
    context.read<OnMapBloc>().add(const GetSavedAddressEvent());
  }

  void showErrorPopup(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Erro',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
