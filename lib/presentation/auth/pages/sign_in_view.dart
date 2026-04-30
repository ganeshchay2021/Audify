import 'package:audify/common/widgets/appbar/app_bar.dart';
import 'package:audify/common/widgets/button/basic_app_button.dart';
import 'package:audify/common/widgets/textfield/app_text_field.dart';
import 'package:audify/core/config/assets/app_vectors.dart';
import 'package:audify/core/routes/app_routes.dart';
import 'package:audify/data/model/auth/user_model.dart';
import 'package:audify/domain/usecases/auth/signin_usecases.dart';
import 'package:audify/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Dispose of controllers to prevent memory leaks
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    var result = await sl<SigninUsecases>().call(
      params: UserModel(
             email: emailController.text.trim().toString(),
        password: passwordController.text.trim().toString(),
      ),
    );

    result.fold(
      (l) {
        // 1. Remove any existing snackbar immediately
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(l, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      (r) async{
        // 1. Remove any existing snackbar immediately
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        var snackBar = SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          content: Text(r, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(appLogo: AppVectors.appLogo,),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: Column(
                    children: [
                      Gap(50),
                      //register text
                      _signInText(),

                      Gap(20),

                      //Textfield for email
                      AppTextField(
                        validate: (value) {
                          if (value == "" || value == null) {
                            return "Email is empty";
                          }
                          return null;
                        },
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter Username or Email",
                        prefixIcon: Icons.email_outlined,
                      ),

                      Gap(20),

                      //Textfield for password
                      AppTextField(
                        validate: (value) {
                          if (value == "" || value == null) {
                            return "Password is empty";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obsecureText: true,
                        suffixIcon: Icons.visibility,
                        textInputType: TextInputType.visiblePassword,
                        hintText: "Password",
                        prefixIcon: Icons.lock_outline,
                      ),

                      Gap(10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            "Recovery Password?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Gap(10),

                      //button
                      BasicAppButton(
                        title: "Sign In",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            Loader.show(context);
                            await signIn();
                            Loader.hide();
                          }
                        },
                        height: 70,
                      ),

                      Gap(20),

                      //Divider
                      Row(
                        children: [
                          Expanded(child: Divider(thickness: 2)),
                          Gap(10),
                          Text("Or", style: TextStyle(fontSize: 15)),
                          Gap(10),
                          Expanded(child: Divider(thickness: 2)),
                        ],
                      ),

                      Gap(20),

                      //social signup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //google button
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                          ),
                          Gap(20),

                          //Apple Button
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.apple, size: 30),
                          ),
                        ],
                      ),

                      Spacer(),
                      Gap(20),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                          text: "Not A Member? ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offNamed(AppRoutes.signUp);
                                },
                              text: "Register now",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(40),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _signInText() {
    return Text(
      "Sign in",
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}
