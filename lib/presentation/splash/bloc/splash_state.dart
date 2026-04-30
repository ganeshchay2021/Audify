abstract class SplashState {}

class InitialState extends SplashState{}

class UnAuthenticated extends SplashState{
  final bool isFirstTime;

  UnAuthenticated({required this.isFirstTime});
}


class Authenticated extends SplashState{}



