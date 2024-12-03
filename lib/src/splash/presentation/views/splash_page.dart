import 'package:cep_finder/core/extensions/context_extension.dart';
import 'package:cep_finder/core/res/colours.dart';
import 'package:cep_finder/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if(mounted){
        context.go('/map');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.tealBlue,
      body: Center(
        child: Lottie.asset(
          height: context.height * 0.4,
          MediaRes.splashAnimation,
          fit: BoxFit.cover,),
      ),
    );
  }

}
