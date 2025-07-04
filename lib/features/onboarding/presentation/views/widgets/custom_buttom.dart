import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? style;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: style ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
