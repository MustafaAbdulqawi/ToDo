import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/cubits/create_task_cubit/create_task_cubit.dart';

class PriorityButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final ValueChanged<String> onSelected;
  final String? value1, value2, value3;

  const PriorityButton({
    super.key,
    required this.text,
    this.icon,
    required this.onSelected,
    this.value1,
    this.value2,
    this.value3,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateTaskCubit>();
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
            icon,
            color: const Color(0XFF5F33E1),
            size: 22.sp,
          ),
          SizedBox(width: 3.w),
          Text(
            cubit.selectedPriority,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0XFF5F33E1),
            ),
          ),
          SizedBox(width: 3.w),
          FocusScope(
            canRequestFocus: false,
            child: PopupMenuButton(
              color: const Color(0XFFF0ECFF),
              icon: Image.asset(
                "assets/Arrow - Down 4.png",
                color: const Color(0XFF5F33E1),
              ),
              onSelected: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
                cubit.selectedPriorityF(value);
                onSelected(value);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: value1,
                  child: Text(
                    value1!,
                  ),
                ),
                PopupMenuItem(
                  value: value2,
                  child: Text(
                    value2!,
                  ),
                ),
                PopupMenuItem(
                  value: value3,
                  child: Text(
                    value3!,
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
