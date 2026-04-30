import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/domain/usecases/auth/signout_usecase.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              _menuTile(Icons.person, "My Profile", () {
                ZoomDrawer.of(context)?.toggle();
                Get.toNamed(AppRoutes.profile);
              }),
              _menuTile(Icons.exit_to_app, "Sign Out", () async {
                Loader.show(context);
                final result = await sl<SignoutUsecase>().call();
                Loader.hide();

                result.fold(
                  (l) {
                    // 1. Remove any existing snackbar immediately
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    var snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        l,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  (r) {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // User must tap CONTINUE to close
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            "Are you sure to you want to logout?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                ZoomDrawer.of(context)?.toggle();
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: context.isDarkMode
                                        ? AppColors.grey
                                        : Colors.black,
                                  ),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : AppColors.darkGrey,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                Get.offNamedUntil(
                                  AppRoutes.signInOrSignUp,
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                "Sign Out",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
