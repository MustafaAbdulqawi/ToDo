import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MoreOfExpLevel extends StatefulWidget {
  final String text;
  final ValueChanged<String> onSelected;

  const MoreOfExpLevel({
    Key? key,
    required this.text,
    required this.onSelected,
  }) : super(key: key);

  @override
  _MoreOfExpLevelState createState() => _MoreOfExpLevelState();
}

class _MoreOfExpLevelState extends State<MoreOfExpLevel> {
  String selectedLevel = "Senior";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          SizedBox(width: 1.w),
        Text(
          selectedLevel,
          style:  TextStyle(
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
            setState(() {
              selectedLevel = value;
            });
            widget.onSelected(value);
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
