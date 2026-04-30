import 'package:audify/presentation/home/page/home_view.dart';
import 'package:audify/presentation/home/widget/menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyMainDrawer extends StatefulWidget {
  const MyMainDrawer({super.key});

  @override
  State<MyMainDrawer> createState() => _MyMainDrawerState();
}

class _MyMainDrawerState extends State<MyMainDrawer> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: const MenuView(), // The screen with "Saved", "Memories", etc.
      mainScreen: const HomeView(), // Your actual feed/home screen
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0, // Set to 0.0 for a slide effect like the video
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * 0.65, 
      menuBackgroundColor: Colors.white,
    );
  }
}