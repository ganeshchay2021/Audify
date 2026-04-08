import 'package:flutter/material.dart';

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
    this.obsecureText = false, required this.controller, this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: controller,
      obscureText: obsecureText,
      keyboardType: textInputType,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: () {},
                icon: Icon(
                  obsecureText ? Icons.visibility : Icons.visibility_off,
                ),
              ),
      ),
    );
  }
}
