import 'package:brasil_fields/brasil_fields.dart';
import 'package:cep_finder/core/common/widgets/bottom_navigation_bar.dart';
import 'package:cep_finder/core/common/widgets/default_text_form_field.dart';
import 'package:cep_finder/core/extensions/context_extension.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cep_finder/src/map/presentation/widgets/list_search_items_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookletPage extends StatefulWidget {
  const BookletPage({super.key});

  static const routeName = 'BookletPage';
  @override
  State<BookletPage> createState() => _BookletPageState();
}

class _BookletPageState extends State<BookletPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController cepController = TextEditingController();
  final FocusNode cepFocusNode = FocusNode();
  bool isShowSearchIcon = false;
  bool isShowHistory = false;
  List<AddressModel> addressList = [];

  @override
  void initState() {
    super.initState();
    getHistory();
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
                        ? const Icon(Icons.close)
                        : null,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        isShowHistory = text.isNotEmpty;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    final addressData = addressList[index];
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
}

