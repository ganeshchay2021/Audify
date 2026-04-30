import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appLogo;
  final String? title;
  final bool? showMenu;
  final VoidCallback? openMenu;

  final bool hideBackBtn;
  const BasicAppBar({
    super.key,
    this.appLogo,
    this.openMenu,

    this.showMenu = false,
    this.hideBackBtn = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title != null
          ? Text(
              "$title",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          : Image.asset("$appLogo", fit: BoxFit.cover, height: 85),

      backgroundColor: context.isDarkMode
          ? Colors.transparent
          : AppColors.lightBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: hideBackBtn
          ? IconButton(
              onPressed: openMenu,
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? AppColors.whiteColor.withOpacity(0.3)
                      : Colors.black.withOpacity(0.08),
                ),
                child: const Icon(Icons.menu),
              ),
            )
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDarkMode
                      ? AppColors.whiteColor.withOpacity(0.3)
                      : Colors.black.withOpacity(0.08),
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ),
      actions: [
        IconButton(
          onPressed: () {
            if (context.isDarkMode) {
              context.read<ThemeCubit>().updateTheme(ThemeMode.light);
            } else {
              context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
            }
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.isDarkMode
                  ? AppColors.whiteColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.08),
            ),
            child: context.isDarkMode
                ? Icon(Icons.light_mode_outlined, size: 25)
                : Icon(Icons.dark_mode_outlined, size: 25),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
