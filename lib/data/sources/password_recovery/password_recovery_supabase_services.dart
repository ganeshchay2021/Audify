import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PasswordRecoverySupabaseServices {
  Future<Either> sendResetToken(String email);
  Future<Either> resetPassword(String email, String token, String password);
}

class PasswordRecoverySupabaseServicesImp
    extends PasswordRecoverySupabaseServices {
  final supabase = Supabase.instance.client;

  @override
  Future<Either> sendResetToken(String email) async {
    try {
      final cleanEmail = email.trim().toLowerCase();

      await supabase.auth.resetPasswordForEmail(cleanEmail);

      return const Right("Success");
    } on AuthApiException catch (e) {
      return Left(e.message.toString());
    }
  }

  @override
  Future<Either<dynamic, dynamic>> resetPassword(
    String email,
    String token,
    String password,
  ) async {
    try {
      final result = await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        email: email.toLowerCase().trim(),
        token: token.trim(),
      );

      if (result.session != null) {
        await supabase.auth.updateUser(
          UserAttributes(password: password.trim()),
        );
      }
      return Right("Success");
    } on AuthException catch (e) {
      return Left(e.message);
    }
  }
}
