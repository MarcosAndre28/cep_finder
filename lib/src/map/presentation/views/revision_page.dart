import 'package:cep_finder/core/common/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';

class RevisionPage extends StatefulWidget {
  const RevisionPage({super.key});

  static const routeName = 'revision';

  @override
  State<RevisionPage> createState() => _RevisionPageState();
}

class _RevisionPageState extends State<RevisionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisão'),
      ),
      body: Column(
        children: [
          DefaultTextFormField(
            hintText: 'CEP',
          ),
          DefaultTextFormField(
            hintText: 'Endereço',
          ),
          DefaultTextFormField(
            hintText: 'Número',
          ),
          DefaultTextFormField(
            hintText: 'Complemento',
          ),
        ],
      ),
    );
  }
}
