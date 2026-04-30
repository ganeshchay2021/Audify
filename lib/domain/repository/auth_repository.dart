import 'package:audify/data/model/auth/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signUp(UserModel userModel);
  Future<Either> signIn(UserModel userModel);
  Future<Either> signOut();
}
