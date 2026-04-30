import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/splash/bloc/splash_cubit.dart';
import 'package:audify/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashCubit()..appStarted(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              if (state.isFirstTime) {
                Get.offAllNamed(AppRoutes.getStart);
              } else {
                Get.offAllNamed(AppRoutes.signInOrSignUp);
              }
            }
            if (state is Authenticated) {
              Get.offAllNamed(AppRoutes.home);
            }
          },
          child: Center(child: Image.asset(AppVectors.appLogo, height: 140)),
        ),
      ),
    );
  }
}
