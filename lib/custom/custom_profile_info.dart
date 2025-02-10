import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomProfileInfo extends StatelessWidget {
  final String hint, info;
  const CustomProfileInfo({
    super.key,
    required this.hint,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.7.h),
      decoration: BoxDecoration(
        color: const Color(0XFFF5F5F5),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hint,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            info,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
