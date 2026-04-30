import 'dart:async';
import 'package:audify/common/bloc/favourite_cubit.dart';
import 'package:audify/common/bloc/favourite_state.dart';
import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/data/model/song/songs_model.dart';
import 'package:audify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:audify/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerView extends StatefulWidget {
  const SongPlayerView({super.key});

  @override
  State<SongPlayerView> createState() => _SongPlayerViewState();
}

class _SongPlayerViewState extends State<SongPlayerView> {
  final SongsModel song = Get.arguments;
  bool isVolumeVisible = false;
  Timer? _volumeTimer;

  // Handles showing the slider and resetting the 2-second auto-hide timer
  void _showVolumeWithTimer() {
    setState(() {
      isVolumeVisible = true;
    });

    _volumeTimer?.cancel();

    _volumeTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isVolumeVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _volumeTimer?.cancel();
    super.dispose();
  }

  String formattedDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String fileName = "${song.title!.trim()} - ${song.artist!.trim()}.mp3";
    String encodedFileName = Uri.encodeComponent(fileName);
    String finalUrl =
        "https://lhnlgskftdzmgzrgrlvn.supabase.co/storage/v1/object/public/songs/$encodedFileName";

    return Scaffold(
      appBar: BasicAppBar(title: "Now Playing"),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(finalUrl, song, true),
        child: Stack(
          // Use Stack to allow floating widgets on top
          children: [
            // Layer 1: Main Player UI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _songCoverImage(size, context),
                    const Gap(20),
                    _songDetails(),
                    const Gap(20),
                    _playbackControls(context),
                  ],
                ),
              ),
            ),

            // Layer 2: Floating Vertical Volume Slider
            if (isVolumeVisible)
              Positioned(
                right: 20, // Distance from the right edge
                top: size.height * 0.15, // Adjusted height placement
                child: _floatingVolumeBar(context),
              ),
          ],
        ),
      ),
    );
  }

  // Widget for the Vertical Floating Bar
  Widget _floatingVolumeBar(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        return Container(
          height: 220,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8), // Dark overlay style
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const Gap(15),
              Icon(
                context.read<SongPlayerCubit>().isMuted
                    ? Icons.volume_off
                    : Icons.volume_up,
                color: Colors.white,
                size: 20,
              ),
              Expanded(
                child: RotatedBox(
                  quarterTurns: 3, // Rotates horizontal slider to vertical
                  child: Slider(
                    value: context.read<SongPlayerCubit>().volume,
                    min: 0.0,
                    max: 1.0,
                    activeColor: AppColors.primary,
                    inactiveColor: Colors.white24,
                    onChanged: (value) {
                      context.read<SongPlayerCubit>().setVolume(value);
                      _showVolumeWithTimer(); // Reset timer on interaction
                    },
                  ),
                ),
              ),
              const Icon(Icons.volume_down, color: Colors.white, size: 20),
              const Gap(15),
            ],
          ),
        );
      },
    );
  }

  // Widget for Progress Bar and Play/Pause
  Widget _playbackControls(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SongPlayerLoadedState) {
          return Column(
            children: [
              Slider(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // Current position of the song
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                // Total duration of the song
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {
                  context.read<SongPlayerCubit>().seek(
                    Duration(seconds: value.toInt()),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                  Text(
                    formattedDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ],
              ),
              Gap(50),
              // Inside your Row of playback controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- LOOP BUTTON ---
                  IconButton(
                    onPressed: () {
                      context.read<SongPlayerCubit>().toggleLoopMode();
                    },
                    icon: Icon(
                      context.read<SongPlayerCubit>().loopMode == LoopMode.one
                          ? Icons.repeat_one
                          : Icons.repeat, size: 40,
                      color:
                          context.read<SongPlayerCubit>().loopMode ==
                              LoopMode.one
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                  ),

                  const Gap(20),

                  // Your existing Play/Pause Button
                  GestureDetector(
                    onTap: () => context.read<SongPlayerCubit>().playOrPause(),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        context.read<SongPlayerCubit>().audioPlayer.playing
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Gap(20),

                  // Your existing Volume Toggle Button
                  IconButton(
                    onPressed: _showVolumeWithTimer,
                    icon: Icon(
                      context.read<SongPlayerCubit>().isMuted
                          ? Icons.volume_off
                          : Icons.volume_up_outlined,
                      color: isVolumeVisible ? AppColors.primary : Colors.grey, size: 40,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _songDetails() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title ?? "Unknown Title",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                song.artist ?? "Unknown Artist",
                style: TextStyle(fontSize: 14, color: AppColors.grey),
              ),
            ],
          ),
        ),
        BlocProvider(
          create: (context) =>
              FavoriteButtonCubit()..checkFavoriteStatus(song.id!),
          child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
            builder: (context, state) {
              bool isFav = state is FavoriteButtonUpdated && state.isFavorite;
              return Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                size: 35,
                color: isFav ? Colors.red : Colors.grey,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _songCoverImage(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.5,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: context.isDarkMode ? Colors.white : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            Uri.encodeFull(
              "https://lhnlgskftdzmgzrgrlvn.supabase.co/storage/v1/object/public/Images/${song.title!.trim()} - ${song.artist!.trim()}.jpg",
            ),
          ),
        ),
      ),
    );
  }
}
