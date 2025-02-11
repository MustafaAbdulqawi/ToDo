import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/sign_up_cubit/sign_up_cubit.dart';

class MoreOfExpLevel extends StatelessWidget {
  final String text;
  final ValueChanged<String> onSelected;

  const MoreOfExpLevel({
    super.key,
    required this.text,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 1.w),
        Text(
          cubit.selectedLevel,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        PopupMenuButton<String>(
          padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
          color: Colors.white,
          icon: const Icon(Icons.arrow_drop_down_sharp),
          onSelected: (value) {
            cubit.chooseLevel(value);
            onSelected(value);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "fresh", child: Text("fresh")),
            const PopupMenuItem(value: "junior", child: Text("junior")),
            const PopupMenuItem(value: "midLevel", child: Text("midLevel")),
            const PopupMenuItem(value: "senior", child: Text("senior")),
          ],
        ),
      ],
    );
  }
}
