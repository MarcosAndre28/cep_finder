import 'package:cep_finder/core/common/widgets/default_button.dart';
import 'package:cep_finder/core/common/widgets/default_text_form_field.dart';
import 'package:cep_finder/core/extensions/context_extension.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/fonts.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RevisionPage extends StatefulWidget {
  const RevisionPage({required this.addressModel, super.key});

  final AddressModel addressModel;
  static const routeName = 'revision';

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController complementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    zipCodeController.text = widget.addressModel.zipcode;
    addressController = TextEditingController(
        text: '${widget.addressModel.street ?? ''}'
            '${widget.addressModel.city}, '
            ' ${widget.addressModel.state}');
    numberController.text = widget.addressModel.number?.toString() ?? '';
    complementController.text = widget.addressModel.complement ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final onMapBloc = context.watch<OnMapBloc>().state;

    return BlocListener<OnMapBloc, OnMapState>(
      listener: (context, state) {
        if (state is SaveAddressState) {
          context.go('/map');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Revisão',
            style: TextStyle(fontFamily: Fonts.roboto, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          leading: IconButton(
            onPressed: () {
              context.go('/map');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colours.black,
            ),
          ),
        ),
        body: onMapBloc is MapLoadingState
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colours.tealBlue,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        DefaultTextFormField(
                          controller: zipCodeController,
                          hintText: 'CEP',
                          readOnly: true,
                          textStyle: TextStyle(
                            fontSize: context.height * 0.025,
                            fontFamily: Fonts.roboto,
                            fontWeight: FontWeight.w600,
                            color: Colours.grey,
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'CEP',
                              style: TextStyle(
                                fontSize: context.height * 0.02,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fonts.roboto,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                        SizedBox(height: context.height * 0.03),
                        DefaultTextFormField(
                          controller: addressController,
                          hintText: 'Endereço',
                          textStyle: TextStyle(
                            fontSize: context.height * 0.025,
                            fontFamily: Fonts.roboto,
                            fontWeight: FontWeight.w600,
                            color: Colours.grey,
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Text(
                              'Endereço',
                              style: TextStyle(
                                fontSize: context.height * 0.02,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fonts.roboto,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                        SizedBox(height: context.height * 0.03),
                        DefaultTextFormField(
                          controller: numberController,
                          hintText: 'Número',
                          keyboardType: TextInputType.number,
                          textStyle: TextStyle(
                            fontSize: context.height * 0.025,
                            fontFamily: Fonts.roboto,
                            fontWeight: FontWeight.w600,
                            color: Colours.black,
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'Número',
                              style: TextStyle(
                                fontSize: context.height * 0.02,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fonts.roboto,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colours.tealBlue),
                            ),
                          ),
                        ),
                        SizedBox(height: context.height * 0.03),
                        DefaultTextFormField(
                          controller: complementController,
                          hintText: 'Complemento',
                          textStyle: TextStyle(
                            fontSize: context.height * 0.025,
                            fontFamily: Fonts.roboto,
                            fontWeight: FontWeight.w600,
                            color: Colours.black,
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              'Complemento',
                              style: TextStyle(
                                fontSize: context.height * 0.02,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fonts.roboto,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colours.tealBlue),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: DefaultButton(
                          onPressed: () {
                            final updatedAddress = widget.addressModel.copyWith(
                              number: int.tryParse(numberController.text),
                              complement: complementController.text,
                              saved: true,
                            );
                            saveAddress(updatedAddress);
                          },
                          child: Text(
                            'Confirmar',
                            style: TextStyle(
                              color: Colours.white,
                              fontSize: context.height * 0.020,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void saveAddress(AddressModel address) {
    context.read<OnMapBloc>().add(SaveAddressEvent(address));
  }
}
