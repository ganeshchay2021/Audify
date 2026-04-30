import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/core/config/assets/app_images.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/data/sources/shared_prefs/shared_preference.dart';
import 'package:audify/presentation/profile/bloc/favourite_song_cubit.dart';
import 'package:audify/presentation/profile/bloc/favourite_song_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String formattedDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, "")}:${seconds.toString().padLeft(2, "")}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      AppImages.homeArtist,
                    ), // Replace with actual image
                  ),
                  Gap(15),
                  FutureBuilder<String?>(
                    future: SharedPreferencesHelper().getUserEmail(),
                    builder: (context, snapshot) {
                      // snapshot.data contains your email
                      return Text(
                        snapshot.data ?? "No Email Found",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  Gap(10),
                  FutureBuilder<String?>(
                    future: SharedPreferencesHelper().getUserName(),
                    builder: (context, snapshot) {
                      // snapshot.data contains your email
                      return Text(
                        snapshot.data ?? "No Email Found",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  Gap(20),
                ],
              ),
            ),

            // --- Playlists Section ---
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FAVOURITE PLAYLISTS",
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),

                  BlocProvider(
                    create: (context) =>
                        FavouriteSongCubit()..getFavouriteSong(),
                    child: BlocBuilder<FavouriteSongCubit, FavouriteSongState>(
                      builder: (context, state) {
                        if (state is FavouriteSongInitialState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FavouriteSongFailedState) {
                          return Center(child: Text(state.errMsg));
                        } else if (state is FavouriteSongLoadedState) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final fsong = state.fsong[index];
                              String fileName =
                                  "${fsong.title!.trim()} - ${fsong.artist!.trim()}.mp3";
                              String encodedFileName = Uri.encodeComponent(
                                fileName,
                              );
                              String finalUrl =
                                  "https://lhnlgskftdzmgzrgrlvn.supabase.co/storage/v1/object/public/songs/$encodedFileName";
                              return _buildPlaylistItem(
                                fsong.title,
                                fsong.artist,
                                finalUrl,
                                fsong,
                              );
                            },
                            separatorBuilder: (context, index) => Gap(0),
                            itemCount: state.fsong.length,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper for Playlist rows
  Widget _buildPlaylistItem(
    String title,
    String artist,
    String finalUrl,
    dynamic song,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.songPlayer, arguments: song);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    Uri.encodeFull(
                      "https://lhnlgskftdzmgzrgrlvn.supabase.co/storage/v1/object/public/Images/${song.title!.trim()} - ${song.artist!.trim()}.jpg",
                    ),
                  ),
                ),
                border: Border.all(
                  color: context.isDarkMode ? AppColors.grey : Colors.black,
                ),
              ),
              child: const Icon(Icons.music_note, color: Colors.white54),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Gap(10),
            Text(
              song.duration.toString().replaceAll('.', ':'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
