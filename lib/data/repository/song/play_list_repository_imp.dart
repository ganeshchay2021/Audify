import 'package:audify/data/sources/songs/play_list_supabase_services.dart';
import 'package:audify/domain/repository/playlist_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class PlayListRepositoryImp extends PlaylistRepository {
  @override
  Future<Either<dynamic, dynamic>> getPlaylist() async {
    return await sl<PlayListSupabaseServices>().getPlaylist();
  }
}
