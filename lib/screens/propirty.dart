import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PriorityButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final ValueChanged<String> onSelected;
  final String? value1, value2, value3;

  const PriorityButton({
    Key? key,
    required this.text,
     this.icon,
    required this.onSelected,
     this.value1,
     this.value2,
     this.value3,
  }) : super(key: key);

  @override
  _PriorityButtonState createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {
  String selectedPriority = "medium";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.7.h),
      decoration: BoxDecoration(
        color: const Color(0XFFF0ECFF),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            widget.icon,
            color: const Color(0XFF5F33E1),
            size: 22.sp,
          ),
          SizedBox(width: 3.w),
          Text(
            selectedPriority,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0XFF5F33E1),
            ),
          ),
          SizedBox(width: 3.w),
          PopupMenuButton<String>(
            color: const Color(0XFFF0ECFF),
            icon: Image.asset(
              "assets/Arrow - Down 4.png",
              color: const Color(0XFF5F33E1),
            ),
            onSelected: (value) {
              setState(() {
                selectedPriority = value;
              });
              widget.onSelected(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: widget.value1,
                child: Text(
                  widget.value1!,
                ),
              ),
              PopupMenuItem(
                value: widget.value2,
                child: Text(
                  widget.value2!,
                ),
              ),
              PopupMenuItem(
                value: widget.value3,
                child: Text(
                  widget.value3!,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
