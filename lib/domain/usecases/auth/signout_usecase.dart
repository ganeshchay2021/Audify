import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/domain/repository/auth_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignoutUsecase implements Usercase {
  @override
  Future<Either> call({params}) async{
    return await sl<AuthRepository>().signOut();
  }
}
