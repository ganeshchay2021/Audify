import 'dart:ui';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final double? height;
  final double? width;
  final IconData icon;
  final VoidCallback onTap;
  final double? iconSize;

  const AppIconButton({
    super.key,
    this.height = 70,
    this.width = 70,
    required this.icon,
    required this.onTap,
    this.iconSize = 35,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Color(0xff30393C).withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
      ),
    );
  }
}
