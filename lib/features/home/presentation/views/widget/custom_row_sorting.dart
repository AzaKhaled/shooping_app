import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class CustomRowSorting extends StatelessWidget {
  const CustomRowSorting({super.key, required this.onSort});

  final VoidCallback onSort;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'All Featured',
          style: TextStyles.montserrat700_36.copyWith(fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        InkWell(
          onTap: onSort,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Text(
                  "Sort",
                  style: TextStyles.montserrat400_10_black.copyWith(fontSize: 12),
                ),
                SizedBox(width: 6),
                Icon(Icons.swap_vert, size: 18, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
