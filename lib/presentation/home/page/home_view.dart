import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/home/widget/artist_songs.dart';
import 'package:audify/presentation/home/widget/home_card.dart';
import 'package:audify/presentation/home/widget/play_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBackBtn: true,
        title: "Home",
        showMenu: true,
        openMenu: () {
          ZoomDrawer.of(context)?.toggle();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeCard(),

            Gap(20),

            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "New Songs",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Gap(10),

            ArtistSongs(),

            Gap(10),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    "Playlists",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Spacer(),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.allPlaylist);
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(10),

            PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTabs() {
    return TabBar(
      onTap: (value) {},
      overlayColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.1)),
      splashBorderRadius: BorderRadius.circular(10),
      indicatorPadding: EdgeInsets.only(bottom: 8),
      isScrollable: true,
      controller: _tabController,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ), // Reduced vertical padding
      tabAlignment: TabAlignment.start,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      unselectedLabelColor: Colors.grey, // Helps differentiate active tab
      indicatorColor: AppColors.primary,
      indicatorWeight: 3.0,
      indicatorSize: TabBarIndicatorSize
          .label, // Indicator matches text width, not full tab width
      indicatorAnimation: TabIndicatorAnimation.elastic,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 30),
      tabs: [
        Tab(text: "News"),
        Tab(text: "Video"),
        Tab(text: "Artists"),
        Tab(text: "Podcasts"),
      ],
    );
  }
}
