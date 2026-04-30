import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/auth/pages/reset_password_view.dart';
import 'package:audify/presentation/auth/pages/sign_in_view.dart';
import 'package:audify/presentation/auth/pages/signup_or_signin_view.dart';
import 'package:audify/presentation/auth/pages/signup_view.dart';
import 'package:audify/presentation/choose_mode/page/choose_mode_view.dart';
import 'package:audify/presentation/auth/pages/forgot_password_view.dart';
import 'package:audify/presentation/home/page/all_play_list_view.dart';
import 'package:audify/presentation/home/page/my_main_drawer.dart';
import 'package:audify/presentation/intro/page/get_started_view.dart';
import 'package:audify/presentation/profile/pages/profile_view.dart';
import 'package:audify/presentation/song_player/page/song_player_view.dart';
import 'package:audify/presentation/splash/page/splash_view.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    // Initial splash screen
    GetPage(name: AppRoutes.splash, page: () => SplashView()),

    //Started screen
    GetPage(name: AppRoutes.getStart, page: () => GetStartedView()),

    // User preference screen (e.g., Light vs Dark mode selection)
    GetPage(name: AppRoutes.choseMode, page: () => ChooseModeView()),

    // Landing page for unauthenticated users to choose between signing in or signing up
    GetPage(name: AppRoutes.signInOrSignUp, page: () => SignupOrSigninView()),

    // Dedicated signin screen
    GetPage(name: AppRoutes.signIn, page: () => SignInView()),

    // Dedicated Registration screen
    GetPage(name: AppRoutes.signUp, page: () => SignupView()),

    // The main home page/dashboard after a user is authenticated
    GetPage(name: AppRoutes.home, page: () => MyMainDrawer()),

    GetPage(name: AppRoutes.songPlayer, page: () => SongPlayerView()),

    GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordView()),

    GetPage(name: AppRoutes.passwordReset, page: () => ResetPasswordView()),

    GetPage(name: AppRoutes.profile, page: () => ProfileView()),

    GetPage(name: AppRoutes.allPlaylist, page: () => AllPlayListView()),

  ];
}
