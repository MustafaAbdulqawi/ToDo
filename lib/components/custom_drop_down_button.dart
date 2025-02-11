import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key, required this.selected ,required this.onSelected, required this.firstValue, required this.secondValue, required this.thirdValue, this.widget});
  final String selected;
  final void Function(String)? onSelected;
  final String firstValue , secondValue, thirdValue;
  final Widget? widget;
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
          widget?? Text(""),
          SizedBox(width: 3.w),

          Text(
            selected,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0XFF5F33E1),
            ),
          ),
          SizedBox(width: 3.w),
          PopupMenuButton<String>(
            onOpened: () {},
            color: const Color(0XFFF0ECFF),
            icon: Image.asset(
              "assets/Arrow - Down 4.png",
              color: const Color(0XFF5F33E1),
            ),
            onSelected: onSelected,
            itemBuilder: (context) => [
               PopupMenuItem(
                value: firstValue,
                child: Text(
                  firstValue,
                ),
              ),
               PopupMenuItem(
                value: secondValue,
                child: Text(
                  secondValue,
                ),
              ),
               PopupMenuItem(
                value: thirdValue,
                child: Text(
                  thirdValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Text(
// selectedStatus ?? data.status,
// style: TextStyle(
// fontSize: 18.sp,
// fontWeight: FontWeight.bold,
// color: const Color(0XFF5F33E1),
// ),
// ),

// (value) {
// setState(() {
// selectedStatus = value;
// context
//     .read<EditTaskCubit>()
//     .edit(
// id: data.id,
// title: titleCon.text,
// desc: descCon.text,
// status: selectedStatus ?? data.status,
// priority: selectedPriority ?? data.priority,
// )
//     .then(
// (v) {
// context.read<GetTaskCubit>().getTasksList();
// },
// );
// });
// },