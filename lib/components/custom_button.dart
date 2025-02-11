import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() pressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: Adaptive.w(85),
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.sp),
          color: const Color(0XFF5F33E1),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
