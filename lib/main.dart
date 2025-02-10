import 'package:cloudinary_dart/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/app_cubit/app_cubit.dart';
import 'package:todo/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:todo/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:todo/cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/cubits/logout_cubit/logout_cubit.dart';
import 'package:todo/cubits/refresh_token_cubit/refresh_token_cubit.dart';
import 'package:todo/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:todo/cubits/user_info_cubit/user_info_cubit.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/profile_screen.dart';
import 'package:todo/screens/signup_screen.dart';
import 'package:todo/screens/start_screen.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/splash_screen.dart';
import 'package:todo/screens/task_details.dart';
import 'package:todo/test.dart';
//var cloudinary=Cloudinary.fromStringUrl('cloudinary://525483914232675:API_SECRET@NXVeI9N672c23UGiYRYks1qKnnc');
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => CreateTaskCubit()),
        BlocProvider(create: (context) => GetTaskCubit()),
        BlocProvider(create: (context) => DeleteTaskCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(create: (context) => RefreshTokenCubit()),
        BlocProvider(create: (context) => UserInfoCubit()),
        BlocProvider(create: (context) => EditTaskCubit()),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            title: 'todo app',
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,error: Colors.white,
                errorContainer: Colors.white,
                secondaryContainer: Colors.white,
              ),
              useMaterial3: true,
            ),
            //  home: const SplashScreen(),
            initialRoute: "/",
            routes: {
              "/": (context) => const SplashScreen(),
              "/start_screen": (context) => const StartScreen(),
              "/login_screen": (context) => const LoginScreen(),
              "/sign_up_screen": (context) => const SignUpScreen(),
              "/home_screen": (context) => const HomeScreen(),
              "/add_task": (context) => const AddTask(),
              "/task_details": (context) => const TaskDetails(),
              "/profile_screen": (context) => const ProfileScreen(),
              "/test_screen": (context) => const TestScreen(),
            },
          );
        },
      ),
    );
  }
}
