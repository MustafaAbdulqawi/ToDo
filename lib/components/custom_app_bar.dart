import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubits/logout_cubit/logout_cubit.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Logo",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            Navigator.pushNamed(
              context,
              "/profile_screen",
            );
          },
          icon: Image.asset(
            "assets/Frame.png",
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<LogoutCubit>().logOutState(context);
          },
          icon: Image.asset(
            "assets/Frame (1).png",
          ),
        ),
      ],
    );
  }
}
