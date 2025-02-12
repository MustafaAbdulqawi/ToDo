import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/cubits/refresh_token_cubit/refresh_token_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkExpiredOrNo();
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

  checkExpiredOrNo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? refreshToken = sharedPreferences.getString("refresh_token");
    if (refreshToken != null) {
      String? newAccessToken =
          await context.read<RefreshTokenCubit>().refreshToken();
      if (newAccessToken != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, "/home_screen", (route) => false);
        return;
      }
    }
    Navigator.pushNamedAndRemoveUntil(
        context, "/start_screen", (route) => false);
  }
}
