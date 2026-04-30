import 'package:audify/core/config/assets/app_images.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 170,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daiaphi | Lamare",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "Run Down\nthe City",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Dhurandhar - The Revenge",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () async {
                // Loader.show(context);
                // await sl<SongsUsecase>().call();
                // Loader.hide();
              },
              child: Image.asset(
                AppImages.homeArtist,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
