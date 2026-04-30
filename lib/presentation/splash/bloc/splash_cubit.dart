import 'package:audify/data/sources/shared_prefs/shared_preference.dart';
import 'package:audify/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitialState());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();

    final bool isFirstTime = prefs.getBool("isFirstTime") ?? true;

    final String? token = await SharedPreferencesHelper().getToken();

    final bool isLoggedIn = token != null;

    if (isFirstTime) {
      emit(UnAuthenticated(isFirstTime: true)); // Go to Get Started
    } else if (!isLoggedIn) {
      emit(UnAuthenticated(isFirstTime: false)); // Go to Sign In
    } else {
      emit(Authenticated()); // Go to Home
    }
  }
}
