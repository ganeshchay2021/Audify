import 'package:audify/data/model/song/songs_model.dart';

abstract class SongsState {}

class SongsLoadingState extends SongsState {}

class SongsLoadedState extends SongsState {
  final List<SongsModel> songs;

  SongsLoadedState({required this.songs});
}

class SongsLoadFailState extends SongsState {
  final String errorMsg;
  SongsLoadFailState({required this.errorMsg});
}
