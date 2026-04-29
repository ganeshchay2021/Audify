import 'package:audify/core/usecases/usercase.dart';
import 'package:audify/domain/repository/song_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:dartz/dartz.dart';

class FavouriteSongUsecase implements Usercase<Either, dynamic> {
  @override
  Future<Either<dynamic, dynamic>> call({params}) async {
    return await sl<SongRepository>().getFavouriteSongs();
  }
}
