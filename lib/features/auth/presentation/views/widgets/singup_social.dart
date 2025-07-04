import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularImageButton extends StatelessWidget {
  const CircularImageButton({
    super.key,
    required this.onPressed,
    required this.imagePath,
    this.size = 60,
  });

  final VoidCallback onPressed;
  final String imagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          elevation: 3,
        ),
        child: ClipOval(
          child: SvgPicture.asset(
            imagePath,
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
