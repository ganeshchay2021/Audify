import 'package:audify/common/bloc/favourite_cubit.dart';
import 'package:audify/common/bloc/favourite_state.dart';
import 'package:audify/common/widgets/button/app_icon_button.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/home/bloc/playlist_cubit.dart';
import 'package:audify/presentation/home/bloc/playlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  String formattedDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, "")}:${seconds.toString().padLeft(2, "")}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PlayListLoadedState) {
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final song = state.song[index];

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.songPlayer, arguments: song);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 0.5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            AppIconButton(
                              height: 40,
                              width: 40,
                              iconSize: 20,
                              icon: Icons.play_arrow_rounded,
                              onTap: () {},
                            ),
                            Gap(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${song.title}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${song.artist}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10),
                            Text(
                              song.duration.toString().replaceAll('.', ':'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(20),
                            BlocProvider(
                              create: (context) =>
                                  FavoriteButtonCubit()
                                    ..checkFavoriteStatus(song.id!),
                              child:
                                  BlocBuilder<
                                    FavoriteButtonCubit,
                                    FavoriteButtonState
                                  >(
                                    builder: (context, state) {
                                      bool isFav = false;
                                      if (state is FavoriteButtonUpdated) {
                                        isFav = state.isFavorite;
                                      }

                                      return IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavoriteButtonCubit>()
                                              .toggleFavorite(song.id!);
                                        },
                                        icon: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,

                                          color: isFav
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Gap(5),
              itemCount: 4,
            );
          } else if (state is PlayListLoadFailState) {
            return Center(child: Text(state.errorMsg));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
