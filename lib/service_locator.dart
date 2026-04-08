import 'package:audify/data/repository/auth/auth_repository_imp.dart';
import 'package:audify/data/sources/auth/auth_firebase_services.dart';
import 'package:audify/domain/repository/auth_repository.dart';
import 'package:audify/domain/usecases/auth/signin_usecases.dart';
import 'package:audify/domain/usecases/auth/signup_usecases.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Registers the Firebase authentication implementation.
  sl.registerSingleton<AuthFirebaseServices>(AuthFirebaseServicesImp());

  // Registers the Repository layer to handle data logic.
  sl.registerSingleton<AuthRepository>(AuthRepositoryImp());

  // Registers the specific Use Case for signing up users.
  sl.registerSingleton<SignupUsecases>(SignupUsecases());

  sl.registerSingleton<SigninUsecases>(SigninUsecases());
}
