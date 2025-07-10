import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).dividerColor;
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Row(
        children: [
          Expanded(child: Divider(color: dividerColor)),
          const SizedBox(width: 18),
          Text(
            'OR Continue with',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
          const SizedBox(width: 18),
          Expanded(child: Divider(color: dividerColor)),
        ],
      ),
    );
  }
}
