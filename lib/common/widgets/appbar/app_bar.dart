import 'package:audify/common/helper/is_dark_mode.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? appLogo;
  const BasicAppBar({super.key, this.appLogo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appLogo == null ? null : Image.asset("$appLogo", fit: BoxFit.cover, height: 85,),
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
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
          icon: Icon(Icons.ac_unit),
        ),
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
