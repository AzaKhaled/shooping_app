import 'package:flutter/material.dart';

class PublicOffireSection extends StatelessWidget {
  const PublicOffireSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(text: 'By clicking the '),
          TextSpan(
            text: 'Register',
            style: TextStyle(
              color: Color(0xffF83758),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: ' button, you agree to the public offer'),
        ],
      ),
    );
  }
}
