import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/view_model/auth_controller.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthController authController = Get.find();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6), () {
      if (authController.token != null) {
        return Get.offAndToNamed(homeView);
      } else {
        return Get.offAndToNamed(switchView);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ]),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/Logo.png',
            fit: BoxFit.cover,
          ),
          // SpinKitChasingDots(color: Colors.white),
          //SpinKitWave(color: Colors.white, type: SpinKitWaveType.center),
          const SpinKitChasingDots(
            color: Colors.white,
          )
        ],
      ),
    ));
  }
}
