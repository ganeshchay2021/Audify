import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  const BasicAppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      onPressed: onTap,
      child: Text(title),
    );
  }
}
