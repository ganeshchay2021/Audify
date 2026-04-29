import 'package:dartz/dartz.dart';

abstract class RecoveryPasswordRepository {
  Future<Either> sendResetToken(String email);
  Future<Either> resetPassword(String email, String token, String password);
}
