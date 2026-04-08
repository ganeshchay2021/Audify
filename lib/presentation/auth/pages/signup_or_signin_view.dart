import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/core/config/assets/app_images.dart';
import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupOrSigninView extends StatelessWidget {
  const SignupOrSigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 160,
              right: -160,
              child: Image.asset(AppImages.authBG),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //App Logo
                    Image.asset(AppVectors.appLogo, height: 150),

                    //text
                    Text(
                      "Enjoy Listening To Music",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Gap(20),

                    //informative text
                    Text(
                      textAlign: TextAlign.center,
                      "Audify is a proprietary Hindi, Nepali audio streaming and media services provider",
                      style: TextStyle(fontSize: 17, color: AppColors.grey),
                    ),

                    Gap(40),
                    //Signup or Login button
                    Row(
                      children: [
                        Expanded(
                          child: BasicAppButton(
                            height: 60,
                            title: "Register",
                            onTap: () {
                              Get.toNamed(AppRoutes.signUp);
                            },
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromHeight(60),
                              side: BorderSide(color: AppColors.grey),
                            ),
                            onPressed: () {
                              Get.toNamed(AppRoutes.signIn);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 16,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
