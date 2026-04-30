abstract class FavouriteSongState {}

class FavouriteSongInitialState extends FavouriteSongState {}

class FavouriteSongLoadedState extends FavouriteSongState {
  final List<dynamic> fsong;

  FavouriteSongLoadedState({required this.fsong});
}

class FavouriteSongFailedState extends FavouriteSongState {
  final String errMsg;

  FavouriteSongFailedState({required this.errMsg});
}
