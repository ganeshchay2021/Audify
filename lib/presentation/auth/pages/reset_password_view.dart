import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/common/widgets/textfield/app_text_field.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/domain/usecases/recover_password/reset_password_usecases.dart';
import 'package:audify/service_locator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordView> {
  // Controllers for form fields
  final _tokenController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _tokenController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final result = await sl<ResetPasswordUsecases>().call(
      params: ResetPassword(
        email: _emailController.text.toLowerCase().trim(),
        password: _passwordController.text.trim(),
        token: _tokenController.text.trim(),
      ),
    );

    result.fold(
      (l) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            l,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      (r) {
        // --- THE FIX: Call showDialog ---
        showDialog(
          context: context,
          barrierDismissible: false, // User must tap button to close
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: const Color(0xFFF9FAF5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Success",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Your password has been reset successfully!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("isFirstTime", false);
                          Get.offNamedUntil(
                            AppRoutes.signIn,
                            (route) => route.isFirst,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: BasicAppBar(title: "Reset new Password"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create new password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Gap(10),
              Text(
                "Enter the reset token from your email and set a new password.",
                style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.grey
                      : AppColors.darkGrey.withOpacity(0.8),
                ),
              ),
              Gap(30),

              // Input Fields
              AppTextField(
                validate: (value) {
                  if (value == "" || value == null) {
                    return "Token is empty";
                  }
                  return null;
                },
                hintText: "Reset token",
                prefixIcon: Icons.key_outlined,
                textInputType: TextInputType.text,
                controller: _tokenController,
                suffixIcon: Icons.content_paste_outlined,
              ),
              Gap(15),
              AppTextField(
                validate: (value) {
                  if (value == "" || value == null) {
                    return "Email is empty";
                  } else if (!EmailValidator.validate(value)) {
                    return "Invalid email address";
                  }
                  return null;
                },
                hintText: "Email address",
                prefixIcon: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              Gap(15),
              AppTextField(
                validate: (value) {
                  if (value == "" || value == null) {
                    return "New password is empty";
                  }
                  return null;
                },
                hintText: "New Password",
                prefixIcon: Icons.lock_outline,
                textInputType: TextInputType.text,
                controller: _passwordController,
                obsecureText: true,
              ),
              Gap(15),
              AppTextField(
                validate: (value) {
                  if (value == "" || value == null) {
                    return "Confirm password is empty";
                  } else if (value.trim() != _passwordController.text.trim()) {
                    return "Password is not match with new password";
                  }
                  return null;
                },
                hintText: "Confirm new Password",
                prefixIcon: Icons.lock_outline,
                textInputType: TextInputType.text,
                controller: _confirmPasswordController,
                obsecureText: true,
              ),

              Gap(30),
              // Action Button
              BasicAppButton(
                height: 60,
                title: "Reset Password",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Loader.show(context);
                    await resetPassword();
                    Loader.hide();
                  }
                },
              ),
              Gap(25),

              // Password Tips Card
              _passwordTipsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4), // Light yellow
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Password Tips",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          SizedBox(height: 8),
          Text("• Use at least 8 characters", style: TextStyle(fontSize: 13)),
          Text(
            "• Include numbers and special characters",
            style: TextStyle(fontSize: 13),
          ),
          Text(
            "• Mix uppercase and lowercase letters",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
