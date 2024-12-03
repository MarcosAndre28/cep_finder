import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cep_finder/core/common/widgets/default_text_form_field.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/src/map/presentation/widgets/list_search_items_map.dart';

import '../../../../core/common/widgets/bottom_navigation_bar.dart';

class BookletPage extends StatefulWidget {
  const BookletPage({super.key});

  static const routeName = 'BookletPage';
  @override
  State<BookletPage> createState() => _BookletPageState();
}

class _BookletPageState extends State<BookletPage> {
  final TextEditingController searchController = TextEditingController();

  bool isShowSearchIcon = false;
  bool isShowHistory = false;
  List<AddressModel> addressList = [];
  List<AddressModel> filteredAddressList = [];

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onMapBloc = context.watch<OnMapBloc>();
    return Scaffold(
      body: BlocListener<OnMapBloc, OnMapState>(
        listener: (context, state) {
          if (state is GetSavedAddressState) {
            if (state.addressModelList.isNotEmpty) {
              setState(() {
                addressList = state.addressModelList;
                filteredAddressList = state.addressModelList;
              });
            }
          }
        },
        child: onMapBloc is MapLoadingState
            ? const Center(child: CircularProgressIndicator())
            : Container(
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
          child: Column(
            children: [
              Material(
                elevation: 15,
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.black.withOpacity(0.5),
                child: DefaultTextFormField(
                  controller: searchController,
                  contentPadding: const EdgeInsets.all(15),
                  keyboardType: TextInputType.text,
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
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(onPressed: () {
                    setState(() {
                      searchController.clear();
                      filteredAddressList = List.from(addressList);
                    });

                  }, icon: const Icon(Icons.clear))
                      : null,
                  onChanged: (text) {
                    setState(() {
                      isShowHistory = text.isNotEmpty;
                      filteredAddressList = addressList
                          .where((address) =>
                          normalizeAddress(address)
                              .contains(normalizeSearchText(text)))
                          .toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredAddressList.length,
                  itemBuilder: (context, index) {
                    final addressData = filteredAddressList[index];
                    return ListSearchItemsMapWidget(
                      zipCode: addressData.zipcode,
                      street: addressData.street ?? '',
                      city: addressData.city,
                      saved: addressData.saved!,
                      onTap: (cep) {
                        // _addMarker(addressData);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }

  void getHistory() {
    context.read<OnMapBloc>().add(const GetSavedAddressEvent());
  }

  String normalizeAddress(AddressModel address) {
    return '${removeAccents((address.street ?? '').toLowerCase())} ${removeAccents((address.city ?? '').toLowerCase())} ${(address.zipcode ?? '').toLowerCase()}';
  }

  String normalizeSearchText(String text) {
    return removeAccents(text.toLowerCase());
  }
  String removeAccents(String text) {
    return text.replaceAll(RegExp(r'[^\x00-\x7F]+'), '');
  }


}
