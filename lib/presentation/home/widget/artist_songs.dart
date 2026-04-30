import 'package:audify/common/widgets/button/app_icon_button.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/home/bloc/songs_cubit.dart';
import 'package:audify/presentation/home/bloc/songs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ArtistSongs extends StatelessWidget {
  const ArtistSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongsCubit()..getSong(),
      child: BlocBuilder<SongsCubit, SongsState>(
        builder: (context, state) {
          if (state is SongsLoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is SongsLoadedState) {
            return SizedBox(
              height: 255,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final song = state.songs[index];

                  return GestureDetector(
                    onTap: () {
                     Get.toNamed(AppRoutes.songPlayer, arguments: song);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 20 : 0,
                        right: 20,
                      ),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: 150,
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
                                  color: context.isDarkMode
                                      ? AppColors.grey
                                      : Colors.transparent,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  transform: Matrix4.translationValues(
                                    5,
                                    10,
                                    0,
                                  ),
                                  child: AppIconButton(
                                    height: 40,
                                    width: 40,
                                    iconSize: 20,
                                    icon: Icons.play_arrow_rounded,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ),

                            const Gap(10),
                            Text(
                              "${song.title}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 18,
                                height: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${song.artist}",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                height: 0,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gap(0),
                itemCount: state.songs.length,
              ),
            );
          } else if (state is SongsLoadFailState) {
            return Center(child: Text("Songs not found"));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
