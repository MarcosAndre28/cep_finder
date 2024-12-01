import 'package:cep_finder/core/services/injection_container.dart';
import 'package:cep_finder/core/services/router.dart';
import 'package:cep_finder/core/theme/theme_app.dart';
import 'package:cep_finder/core/utils/google_maps_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  await GoogleMapsUtils.updateGoogleMapsApiKey();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
