import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/common/widgets/textfield/app_text_field.dart';
import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/config/theme/app_colors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/domain/repository/recovery_password_repository.dart';
import 'package:audify/service_locator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> sendResetToken() async {
    final result = await sl<RecoveryPasswordRepository>().sendResetToken(
      _emailController.text.toString(),
    );

    result.fold(
      (l) {
        // 1. Remove any existing snackbar immediately
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            l,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      (r) {
        showDialog(
          context: context,
          barrierDismissible: false, // User must tap CONTINUE to close
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                "Check Your Email",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              content: Text(
                "If an account exists with this email, a reset token has been sent to your email. Please check your inbox and use the token to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: context.isDarkMode
                      ? AppColors.grey
                      : AppColors.darkGrey,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppRoutes.passwordReset);
                  },
                  child: const Text(
                    "CONTINUE",
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(appLogo: AppVectors.appLogo),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              const Text(
                'Forgot your password?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gap(8),
              const Text(
                'Enter your email address below and we\'ll send you a reset token.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Gap(32),

              // Email Field
              AppTextField(
                validate: (value) {
                  if (value == "" || value == null) {
                    return "Email is empty";
                  } else if (!EmailValidator.validate(value)) {
                    return "Invalid email address";
                  }
                  return null;
                },
                hintText: "Enter registered email",
                prefixIcon: Icons.email_outlined,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),

              Gap(30),

              // Send Button
              BasicAppButton(
                height: 60,
                title: "Send Reset Token",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Loader.show(context);
                    await sendResetToken();
                    Loader.hide();
                  }
                },
              ),
              Gap(32),

              // Instructions Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, size: 18, color: Colors.green),
                        Gap(8),
                        Text(
                          'What happens next?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Gap(12),
                    _buildStepText(
                      '1. We\'ll send a reset token to your email',
                    ),
                    Gap(4),
                    _buildStepText('2. Check your inbox (and spam folder)'),
                    Gap(4),
                    _buildStepText(
                      '3. Copy the token and use it on the next screen',
                    ),
                  ],
                ),
              ),
              Gap(40),

              // Footer Link
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.passwordReset);
                  },
                  child: const Text(
                    'Already have a reset token?',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 13, color: AppColors.primary, height: 1.4),
    );
  }
}
