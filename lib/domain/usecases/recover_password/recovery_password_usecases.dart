import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/domain/repository/recovery_password_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class RecoveryPasswordUsecases implements Usercase<Either, String> {
  @override
  Future<Either<dynamic, dynamic>> call({String? params}) async {
    return await sl<RecoveryPasswordRepository>().sendResetToken(params!);
  }
}
