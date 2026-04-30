import 'package:audify/presentation/auth/bloc/show_password_cubit.dart';
import 'package:audify/presentation/auth/bloc/show_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool obsecureText;
  final TextEditingController controller;
  final String? Function(String?)? validate;

  final TextInputType textInputType;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.textInputType,
    this.suffixIcon,
    this.obsecureText = false,
    required this.controller,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowPasswordCubit(),
      child: BlocBuilder<ShowPasswordCubit, ShowPasswordState>(
        builder: (context, state) {
          bool isVisible = context.read<ShowPasswordCubit>().showPassword;
          return TextFormField(
            validator: validate,
            controller: controller,
            obscureText: obsecureText ? isVisible : false,
            keyboardType: textInputType,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(prefixIcon),
              suffixIcon: obsecureText
                  ? IconButton(
                      onPressed: () {
                        context.read<ShowPasswordCubit>().togglePassword();
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : suffixIcon == null
                  ? null
                  : Icon(suffixIcon),
            ),
          );
        },
      ),
    );
  }
}
