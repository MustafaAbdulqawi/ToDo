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
      height: 10.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0XFFF5F5F5),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hint,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.sp,
              ),
            ),
            Text(
              info,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
