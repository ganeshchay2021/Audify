import 'package:audify/data/repository/auth/auth_repository_imp.dart';
import 'package:audify/data/repository/password_recovery/password_recovery_repository_imp.dart';
import 'package:audify/data/repository/song/play_list_repository_imp.dart';
import 'package:audify/data/repository/song/songs_repository_imp.dart';
import 'package:audify/data/sources/auth/auth_supabase_services.dart';
import 'package:audify/data/sources/password_recovery/password_recovery_supabase_services.dart';
import 'package:audify/data/sources/songs/play_list_supabase_services.dart';
import 'package:audify/data/sources/songs/song_supabase_services.dart';
import 'package:audify/domain/repository/auth_repository.dart';
import 'package:audify/domain/repository/playlist_repository.dart';
import 'package:audify/domain/repository/recovery_password_repository.dart';
import 'package:audify/domain/repository/song_repository.dart';
import 'package:audify/domain/usecases/auth/signin_usecases.dart';
import 'package:audify/domain/usecases/auth/signout_usecase.dart';
import 'package:audify/domain/usecases/auth/signup_usecases.dart';
import 'package:audify/domain/usecases/recover_password/recovery_password_usecases.dart';
import 'package:audify/domain/usecases/recover_password/reset_password_usecases.dart';
import 'package:audify/domain/usecases/songs/favourite_song_usecase.dart';
import 'package:audify/domain/usecases/songs/playlist_usecase.dart';
import 'package:audify/domain/usecases/songs/songs_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Registers the Firebase authentication implementation.
  sl.registerSingleton<AuthSupabaseServices>(AuthSupabaseServicesImp());

  // Registers the Repository layer to handle data logic.
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());

  // Registers the specific Use Case for signing up users.
  sl.registerSingleton<SignupUsecases>(SignupUsecases());

  sl.registerSingleton<SigninUsecases>(SigninUsecases());

  sl.registerSingleton<SongSupabaseServices>(SongSupabaseServicesImp());

  // Registers the Repository layer to handle data logic.
  sl.registerSingleton<SongRepository>(SongsRepositoryImp());

  sl.registerSingleton<SongsUsecase>(SongsUsecase());

  sl.registerSingleton<PlayListSupabaseServices>(PlayListSupabaseServicesImp());

  // Registers the Repository layer to handle data logic.
  sl.registerSingleton<PlaylistRepository>(PlayListRepositoryImp());

  sl.registerSingleton<PlaylistUsecase>(PlaylistUsecase());

  sl.registerSingleton<SignoutUsecase>(SignoutUsecase());

  sl.registerSingleton<RecoveryPasswordRepository>(
    PasswordRecoveryRepositoryImp(),
  );

  sl.registerSingleton<PasswordRecoverySupabaseServices>(
    PasswordRecoverySupabaseServicesImp(),
  );

  sl.registerSingleton<ResetPasswordUsecases>(ResetPasswordUsecases());

  sl.registerSingleton<FavouriteSongUsecase>(FavouriteSongUsecase());

}
