import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static String userIDKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String token = "token";


  Future<bool> saveUserId(String setUserId) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.setString(userIDKey, setUserId);
  }

  Future<bool> saveUserName(String setUserName) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.setString(userNameKey, setUserName);
  }

  Future<bool> saveUserEmail(String setUserEmail) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.setString(userEmailKey, setUserEmail);
  }

   Future<bool> saveToken(String saveToken) async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.setString(token, saveToken);
  }


  Future<String?> getUserId() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.getString(userIDKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.getString(userEmailKey);
  }

  Future<String?> getToken() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    return prefes.getString(token);
  }

  Future<void> deleteUserInfo() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    await prefes.clear();
  }
}
