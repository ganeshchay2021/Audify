import 'package:audify/data/model/song/favourite_song_model.dart';
import 'package:audify/data/model/song/songs_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PlayListSupabaseServices {
  Future<Either> getPlaylist();
  Future<Either> getFavouriteSong();
}

class PlayListSupabaseServicesImp extends PlayListSupabaseServices {
  final supabase = Supabase.instance.client;

  @override
  Future<Either<dynamic, dynamic>> getPlaylist() async {
    try {
      final response = await supabase.from('Songs').select();

      final songs = response
          .map((songMap) => SongsModel.fromMap(songMap))
          .toList();

      return Right(songs);
    } on AuthException catch (e) {
      // Supabase returns clear messages in e.message
      return Left(e.message);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  @override
  Future<Either<dynamic, List<SongsModel>>> getFavouriteSong() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await Supabase.instance.client
          .from('Songs')
          .select('''
        id,
        title,
        duration,
        releaseDate,
        artist,
        favorites!inner(user_id)
      ''')
          .eq('favorites.user_id', userId);
      final result = data
          .map((song) => SongsModel.fromMap(song))
          .toList();

      return Right(result);
    } on AuthApiException catch (e) {
      return Left(e.message);
    }
  }
}
