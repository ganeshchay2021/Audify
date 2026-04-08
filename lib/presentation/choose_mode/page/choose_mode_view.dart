import 'package:audify/common/widgets/button/app_icon_button.dart';
import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/core/config/assets/app_images.dart';
import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChooseModeView extends StatelessWidget {
  const ChooseModeView({super.key});

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
                  image: AssetImage(AppImages.introBG2),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    //app logo
                    Image.asset(AppVectors.appLogo, height: 120),

                    Spacer(),

                    //text
                    Text(
                      "Choose Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.whiteColor,
                      ),
                    ),

                    Gap(40),

                    //chose dark and light mode
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            //app icon
                            AppIconButton(
                              icon: Icons.dark_mode_outlined,
                              onTap: () {
                                context.read<ThemeCubit>().updateTheme(
                                  ThemeMode.dark,
                                );
                              },
                            ),

                            Gap(15),
                            
                            //dark mode text
                            Text(
                              "Dark Mode",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Gap(40),

                        Column(
                          children: [
                            //app icon
                            AppIconButton(
                              icon: Icons.light_mode_outlined,
                              onTap: () {
                                context.read<ThemeCubit>().updateTheme(
                                  ThemeMode.light,
                                );
                              },
                            ),

                            Gap(15),
                            //dark mode text
                            
                            Text(
                              "Light Mode",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Gap(50),

                    //Continue button
                    BasicAppButton(
                      title: "Continue",
                      onTap: () {
                        Get.offNamed(AppRoutes.signInOrSignUp);
                      },
                      height: 60,
                    ),

                    Gap(20),
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
