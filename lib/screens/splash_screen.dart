import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/cubits/refresh_token_cubit/refresh_token_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0XFF5f33e1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'y',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0XFFF5F876),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  test() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (sharedPreferences.getString("refresh_token") != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/home_screen", (route) => false);
      } else {
        context.read<RefreshTokenCubit>().refreshToken();
        Navigator.pushNamedAndRemoveUntil(
            context, "/login_screen", (route) => false);
      }
    });
  }
}
