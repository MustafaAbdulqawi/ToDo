import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDateDetails extends StatelessWidget {
  const CustomDateDetails({super.key, required this.dateText});
  final String dateText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.7.h),
      height: 7.h,
      decoration: BoxDecoration(
        color: const Color(0XFFF0ECFF),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Row(
        children: [
          const Spacer(),
          Text(
            dateText,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.date_range,
            color: Color(0XFF5F33E1),
          ),
          SizedBox(
            width: 6.5.w,
          ),
        ],
      ),
    );
  }
}
