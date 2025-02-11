import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/cubits/user_info_cubit/user_info_cubit.dart';
import 'package:todo/custom/custom_profile_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<UserInfoCubit>().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.read<GetTaskCubit>().getTasksList();
            Navigator.pop(context);
          },
          icon: Image.asset("assets/Arrow - Left00.png"),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: context.read<UserInfoCubit>().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                CustomProfileInfo(
                  hint: "NAME",
                  info: snapshot.data?.displayName ?? "Error",
                ),
                CustomProfileInfo(
                  hint: "PHONE",
                  info: snapshot.data?.username ?? "Error",
                ),
                CustomProfileInfo(
                  hint: "LEVEL",
                  info: snapshot.data?.level ?? "Error",
                ),
                CustomProfileInfo(
                  hint: "YEARS OF EXPERIENCE",
                  info: snapshot.data?.experienceYears == null
                      ? "Error"
                      : "${snapshot.data?.experienceYears} Years",
                ),
                CustomProfileInfo(
                  hint: "LOCATION",
                  info: snapshot.data?.address ?? "Error",
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0XFF5f33e1),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Error",
              ),
            );
          }
        },
      ),
    );
  }
}
