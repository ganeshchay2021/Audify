import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabase {
  final database = Supabase.instance.client.from("Users");

  Future<void> crateUser(Map<dynamic, String> userInfo) async {
    await database.insert(userInfo);
  }
}
