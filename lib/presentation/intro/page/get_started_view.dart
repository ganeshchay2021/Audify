import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/core/config/assets/app_images.dart';
import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.introBG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    //app logo
                    Image.asset(AppVectors.appLogo, height: 120),

                    Spacer(),

                    //Text
                    Text(
                      "Enjoy Listening To Music",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.whiteColor,
                      ),
                    ),

                    Gap(20),

                    //informative text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "play your favourite playlists, artists and genres. Just play Today's Top Hits. Listen your speakers using the Audify app as remote",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.grey,
                        ),
                      ),
                    ),

                    Gap(20),

                    //Get Statted button
                    BasicAppButton(
                      title: "Get Started",
                      onTap: () {
                        Get.offNamed(AppRoutes.choseMode);
                      },
                      height: 60,
                    ),

                    Gap(20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
