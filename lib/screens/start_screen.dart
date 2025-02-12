import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/components/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/ART.png",
          ),
          SizedBox(
            height: 5.h,
          ),
          const Text(
            textAlign: TextAlign.center,
            "Task Management &\n To-Do List",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          const Text(
            textAlign: TextAlign.center,
            " This productive tool is designed to help\n you better manage your task\n project-wise conveniently!",
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: CustomButton(
              text: "Let's Start",
              pressed: () {
                Navigator.pushNamed(
                  context,
                  "/login_screen",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
