import 'package:audify/domain/usecases/songs/favourite_song_usecase.dart';
import 'package:audify/presentation/profile/bloc/favourite_song_state.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteSongCubit extends Cubit<FavouriteSongState> {
  FavouriteSongCubit() : super(FavouriteSongInitialState());

  Future<void> getFavouriteSong() async {
    final result = await sl<FavouriteSongUsecase>().call();
    result.fold(
      (error) => emit(FavouriteSongFailedState(errMsg: error)),
      (data) => emit(FavouriteSongLoadedState(fsong: data)),
    );
  }
}
