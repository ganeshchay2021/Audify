import 'package:audify/data/sources/password_recovery/password_recovery_supabase_services.dart';
import 'package:audify/domain/repository/recovery_password_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class PasswordRecoveryRepositoryImp extends RecoveryPasswordRepository {
  @override
  Future<Either> sendResetToken(String email) async {
    return await sl<PasswordRecoverySupabaseServices>().sendResetToken(email);
  }

  @override
  Future<Either<dynamic, dynamic>> resetPassword(
    String email,
    String token,
    String password,
  ) async {
    return await sl<PasswordRecoverySupabaseServices>().resetPassword(
      email,
      token,
      password,
    );
  }
}
