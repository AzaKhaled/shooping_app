import 'package:flutter/material.dart';

class HaveAnAccountSection extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final VoidCallback onTap;

  const HaveAnAccountSection({
    super.key,
    required this.leadingText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(leadingText, style: const TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              color: Color(0xffF83758),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
