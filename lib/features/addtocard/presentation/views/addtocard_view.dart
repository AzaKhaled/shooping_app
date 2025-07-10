import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruits_hub/features/addtocard/presentation/views/widgets/addtocard_view_body.dart';
import 'package:fruits_hub/features/home/presentation/views/widget/custom_home_appbar.dart';

class AddtocardView extends StatelessWidget {
  const AddtocardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: const CustomHomeAppbar(),
      ),
      body: SafeArea(child: AddtocardViewBody()),
    );
  }
}
