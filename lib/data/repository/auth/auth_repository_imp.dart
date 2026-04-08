import 'package:audify/data/model/auth/user_model.dart';
import 'package:audify/data/sources/auth/auth_firebase_services.dart';
import 'package:audify/domain/repository/auth_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImp extends AuthRepository {
   @override
  Future<Either> signUp(UserModel userModel) async {
    return await sl<AuthFirebaseServices>().signUp(userModel);
  }
  
  @override
  Future<Either<dynamic, dynamic>> signIn(UserModel userModel) async{
      return await sl<AuthFirebaseServices>().signIn(userModel);
  }
}
