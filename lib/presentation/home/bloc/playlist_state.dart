import 'package:audify/data/model/song/songs_model.dart';

abstract class PlayListState {}

class PlayListLoadingState extends PlayListState {}

class PlayListLoadedState extends PlayListState {
  final List<SongsModel> song;

  PlayListLoadedState({required this.song});
}

class PlayListLoadFailState extends PlayListState {
  final String errorMsg;
  PlayListLoadFailState({required this.errorMsg});
}
