import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class CustomHomeAppbar extends StatelessWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.shogginglogo, width: 20.w, height: 30.h),
          SizedBox(width: 4.w),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Shop',
                  style: TextStyles.montserrat400_10_black.copyWith(
                    color: const Color(0xFF4392F9), 
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'ping',
                  style: TextStyles.montserrat400_10_black.copyWith(
                    color: const Color(0xFFFA7189), // وردي
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
