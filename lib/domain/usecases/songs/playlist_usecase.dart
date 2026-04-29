import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/domain/repository/playlist_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class PlaylistUsecase extends Usercase<Either, dynamic> {
  @override
  Future<Either<dynamic, dynamic>> call({params}) async {
    return await sl<PlaylistRepository>().getPlaylist();
  }
}
