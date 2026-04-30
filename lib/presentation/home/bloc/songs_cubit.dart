import 'package:audify/domain/usecases/songs/songs_usecase.dart';
import 'package:audify/presentation/home/bloc/songs_state.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsLoadingState());

  Future<void> getSong() async {
    final result = await sl<SongsUsecase>().call();

    result.fold(
      (errorMsg) => emit(SongsLoadFailState(errorMsg: errorMsg)),
      (songs) => emit(SongsLoadedState(songs: songs)),
    );
  }

 }
