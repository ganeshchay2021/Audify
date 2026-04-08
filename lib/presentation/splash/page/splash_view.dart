import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    redirect();
    super.initState();
  }

  Future<void> redirect()async {
    await Future.delayed(Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.getStart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppVectors.appLogo, height: 140)),
    );
  }
}
