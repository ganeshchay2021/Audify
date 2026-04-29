import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getSongs();
  Future<Either> getFavouriteSongs();
}
