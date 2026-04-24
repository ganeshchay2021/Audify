import 'package:audify/common/bloc/favourite_state.dart';
import 'package:audify/data/sources/songs/song_supabase_services.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> checkFavoriteStatus(int songId) async {
    final result = await sl<SongSupabaseServices>().isFavorite(songId);
    emit(FavoriteButtonUpdated(result));
  }

  Future<void> toggleFavorite(int songId) async {
    final result = await sl<SongSupabaseServices>().toggleFavorite(songId);
    emit(FavoriteButtonUpdated(result));
  }
}