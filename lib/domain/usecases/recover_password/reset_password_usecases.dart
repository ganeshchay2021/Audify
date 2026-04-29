import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/domain/repository/recovery_password_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecases implements Usercase<Either, ResetPassword> {
  @override
  Future<Either<dynamic, dynamic>> call({ResetPassword? params}) async {
    return await sl<RecoveryPasswordRepository>().resetPassword(
      params!.email,
      params.token,
      params.password,
    );
  }
}

class ResetPassword {
  final String email;
  final String password;
  final String token;

  ResetPassword({
    required this.email,
    required this.password,
    required this.token,
  });
}
