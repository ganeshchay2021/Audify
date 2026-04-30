import 'package:audify/data/model/song/songs_model.dart';
import 'package:audify/presentation/song_player/bloc/song_player_state.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioAssetPlayer.instance;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  double volume = 1.0;
  LoopMode loopMode = LoopMode.off;

  SongPlayerCubit() : super(SongPlayerLoadingState()) {
    audioPlayer.positionStream.listen((position) {
      if (!isClosed) {
        // ALWAYS check this
        songPosition = position;
        updateSongPlayer();
      }
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoadedState());
  }

  Future<void> loadSong(String url, SongsModel? song, bool autoplay) async {
    try {
      // if (audioPlayer.playing) {
      //   await audioPlayer.stop();
      // }
      // Create the AudioSource with Metadata
      final audioSource = AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: song!.id.toString(),
          album: "Audify",
          title: song.title!,
          artist: song.artist!,
          // This image shows in your notification
          artUri: Uri.parse(
            "https://lhnlgskftdzmgzrgrlvn.supabase.co/storage/v1/object/public/Images/${song.title!.trim()} - ${song.artist!.trim()}.jpg",
          ),
        ),
      );

      await audioPlayer.setAudioSource(audioSource);

      // --- AUTOMATIC PLAY ---
      if (autoplay) {
        audioPlayer.play();
      }

      emit(SongPlayerLoadedState());
    } catch (e) {
      emit(SongPlayerLoadingState());
    }
  }

  void toggleLoopMode() {
    if (loopMode == LoopMode.off) {
      loopMode = LoopMode.one; // Loops the current song
    } else {
      loopMode = LoopMode.off; // Disables loop
    }

    audioPlayer.setLoopMode(loopMode);
    emit(SongPlayerLoadedState()); // Rebuild UI to update icon
  }

  void playOrPause() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }

    emit(SongPlayerLoadedState());
  }

  void setVolume(double value) {
    volume = value;
    audioPlayer.setVolume(value);
    emit(SongPlayerLoadedState()); // Refresh UI
  }

  // Optional: Toggle Mute
  void toggleMute() {
    if (volume > 0) {
      setVolume(0.0);
    } else {
      setVolume(1.0);
    }
  }

  bool get isMuted => volume <= 0;

  // Inside your SongPlayerCubit class

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    audioPlayer.stop();
    // audioPlayer.dispose();
    return super.close();
  }
}

class AudioAssetPlayer {
  // Static instance ensures only ONE player exists in the whole app
  static final AudioPlayer _instance = AudioPlayer();

  static AudioPlayer get instance => _instance;
}
