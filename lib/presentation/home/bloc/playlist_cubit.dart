import 'package:audify/domain/usecases/songs/playlist_usecase.dart';
import 'package:audify/presentation/home/bloc/playlist_state.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistCubit extends Cubit<PlayListState> {
  PlaylistCubit() : super(PlayListLoadingState());

  Future<void> getPlaylist() async {
    final result = await sl<PlaylistUsecase>().call();
    result.fold(
      (errorMsg) => emit(PlayListLoadFailState(errorMsg: errorMsg)),
      (song) => emit(PlayListLoadedState(song: song)),
    );
  }
}
