import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/data/model/auth/user_model.dart';
import 'package:audify/domain/repository/auth_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUsecases implements Usercase<Either, UserModel>{
  @override
  Future<Either> call({UserModel? params})async{
    return await sl<AuthRepository>().signUp(params!);
  }
}