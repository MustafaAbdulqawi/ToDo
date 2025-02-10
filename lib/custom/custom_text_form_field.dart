import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final bool? obscureText;
  final double? verticalSize;
  final int? maxLines;
  const CustomTextFormField({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.verticalSize,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      child: TextFormField(
        expands: false,
        maxLines: maxLines ?? 1,
        keyboardType: TextInputType.multiline,
        scrollPhysics: BouncingScrollPhysics(),
        obscureText: obscureText ?? false,
        controller: controller,
        cursorColor: const Color(0XFFBABABA),
        style: const TextStyle(
          color: Colors.black,
          decorationColor: Colors.black,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          labelStyle: const TextStyle(
            color: Color(0XFFBABABA),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0XFFBABABA),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalSize ?? 2.2.h, horizontal: 3.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(
              color: Color(0XFFBABABA),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: const BorderSide(
              color: Color(0XFFBABABA),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
