import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/cubits/app_cubit/app_cubit.dart';
import 'package:tasky/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:tasky/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:tasky/cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:tasky/cubits/logout_cubit/logout_cubit.dart';
import 'package:tasky/cubits/refresh_token_cubit/refresh_token_cubit.dart';
import 'package:tasky/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:tasky/cubits/user_info_cubit/user_info_cubit.dart';
import 'package:tasky/screens/add_task_screen.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/login_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/signup_screen.dart';
import 'package:tasky/screens/splash_screen.dart';
import 'package:tasky/screens/start_screen.dart';
import 'package:tasky/screens/task_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
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
            title: 'Task',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.white,
                error: Colors.white,
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
            },
          );
        },
      ),
    );
  }
}
