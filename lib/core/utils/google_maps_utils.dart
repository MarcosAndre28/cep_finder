import 'dart:io';

import 'package:cep_finder/core/res/media_res.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleMapsUtils {
  static Future<void> updateGoogleMapsApiKey() async {
    await dotenv.load(fileName: '.env');

    const filePath = MediaRes.filePath;
    final file = File(filePath);

    String googleMapsApiKey = dotenv.env['GOOGLE_MAP_KEY'] ?? '';

    // Imprimir a chave da API no console
    print('Chave da API do Google Maps: $googleMapsApiKey');

    if (await file.exists()) {
      final content = await file.readAsString();
      final newContent = content.replaceAll(
        'GOOGLE_MAP_KEY',
        dotenv.env['GOOGLE_MAP_KEY'] ?? '',
      );

      await file.writeAsString(newContent);

      print('Chave da API do Google Maps atualizada com sucesso no $filePath');
    } else {
      print('Arquivo $filePath não encontrado.');
    }
  }
}
