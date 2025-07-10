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
    final textTheme = Theme.of(context).textTheme.bodyMedium;

    return Wrap(
      children: [
        Text(leadingText, style: textTheme),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: textTheme?.copyWith(
              color: const Color(0xffF83758),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
