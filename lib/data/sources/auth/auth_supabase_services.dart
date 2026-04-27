import 'package:audify/data/model/auth/user_model.dart';
import 'package:audify/data/sources/database/datebase.dart';
import 'package:audify/data/sources/shared_prefs/shared_preference.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthSupabaseServices {
  Future<Either> signUp(UserModel userModel);
  Future<Either> signIn(UserModel userModel);
  Future<Either> signOut();
}

class AuthSupabaseServicesImp extends AuthSupabaseServices {
  final supabase = Supabase.instance.client;
  @override
  Future<Either> signUp(UserModel userModel) async {
    try {
      final AuthResponse authResponse = await supabase.auth.signUp(
        password: userModel.password.trim(),
        email: userModel.email.toLowerCase().trim(),
      );

      final String? id = authResponse.user?.id;

      if (id != null) {
        Map<dynamic, String> userInfo = {
          "id": id,
          "full_name": userModel.fullName!.toLowerCase().trim(),
          "email": userModel.email.trim(),
        };
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isFirstTime", false);

        final String? token = authResponse.session?.accessToken;

        await SharedPreferencesHelper().saveToken(token!);
        await SharedPreferencesHelper().saveUserId(id);
        await SharedPreferencesHelper().saveUserName(userModel.fullName!);
        await SharedPreferencesHelper().saveUserEmail(userModel.email);

        await SupabaseDatabase().crateUser(userInfo);
      }

      return Right("Account Register Successfully");
    } on AuthException catch (e) {
      // Supabase returns clear messages in e.message
      return Left(e.message);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  @override
  Future<Either<dynamic, dynamic>> signIn(UserModel userModel) async {
    try {
      final result = await supabase.auth.signInWithPassword(
        email: userModel.email.toLowerCase().trim(),
        password: userModel.password.trim(),
      );

      final String userId = result.user!.id;

      final userData = await supabase
          .from('Users')
          .select()
          .eq('id', userId)
          .single();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isFirstTime", false);

      final sharedPrefs = SharedPreferencesHelper();

      final String? token = result.session?.accessToken;

      await sharedPrefs.saveToken(token!);
      await sharedPrefs.saveUserId(userId);
      await sharedPrefs.saveUserEmail(userData['email']);
      await sharedPrefs.saveUserName(userData['full_name']);

      return Right("Login Successfully");
    } on AuthException catch (e) {
      // Supabase returns clear messages in e.message
      return Left(e.message);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      await SharedPreferencesHelper().deleteUserInfo();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isFirstTime", false);
      await supabase.auth.signOut();
      return Right("Logged out successfully");
    } catch (e) {
      return Left("Logout failed: $e");
    }
  }
}
