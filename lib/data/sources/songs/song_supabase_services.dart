import 'package:audify/data/model/song/songs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SongSupabaseServices {
  Future<Either> getSongs();
  Future<bool> isFavorite(int songId);
  Future<bool> toggleFavorite(int songId);
}

class SongSupabaseServicesImp extends SongSupabaseServices {
  final supabase = Supabase.instance.client;

  @override
  Future<Either<String, List<SongsModel>>> getSongs() async {
    try {
      final response = await supabase
          .from('Songs')
          .select()
          .order('releaseDate', ascending: true);

      // if (response.isEmpty) {
      //   print("Check RLS policies: The table is returning 0 rows.");
      // }

      final songs = response
          .map((songMap) => SongsModel.fromMap(songMap))
          .toList();

      print(response);

      return Right(songs);
    } on AuthException catch (e) {
      // Supabase returns clear messages in e.message
      return Left(e.message);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  @override
  Future<bool> toggleFavorite(int songId) async {
    final userId = supabase.auth.currentUser!.id;

    // Check if favorite exists
    final res = await supabase
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('song_id', songId)
        .maybeSingle();

    if (res == null) {
      // Add to favorite
      await supabase.from('favorites').insert({
        'user_id': userId,
        'song_id': songId,
      });
      return true;
    } else {
      // Remove from favorite
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('song_id', songId);
      return false;
    }
  }

  @override
  Future<bool> isFavorite(int songId) async {
    final userId = supabase.auth.currentUser!.id;
    final res = await supabase
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('song_id', songId)
        .maybeSingle();
    return res != null;
  }
}
