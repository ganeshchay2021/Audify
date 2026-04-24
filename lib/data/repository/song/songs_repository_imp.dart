import 'package:audify/data/sources/songs/play_list_supabase_services.dart';
import 'package:audify/data/sources/songs/song_supabase_services.dart';
import 'package:audify/domain/repository/song_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class SongsRepositoryImp extends SongRepository{
  @override
  Future<Either<dynamic, dynamic>> getSongs() async{
    return await sl<SongSupabaseServices>().getSongs();
  }
  
  @override
  Future<Either<dynamic, dynamic>> getFavouriteSongs() async{
    return await sl<PlayListSupabaseServices>().getFavouriteSong();
  }
}