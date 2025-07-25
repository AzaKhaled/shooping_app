import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class OnboardingViewItems extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingViewItems({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SvgPicture.asset(
              imagePath,
              width: 200.w,
              height: 250.h,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyles.montserrat800_24.copyWith(
  color: Theme.of(context).textTheme.bodyLarge!.color,
),

            ),
            SizedBox(height: 16.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyles.montserrat600_14_grey,
            ),
          ],
        ),
      ),
    );
  }
}
