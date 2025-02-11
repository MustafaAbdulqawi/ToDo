import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/cubits/logout_cubit/logout_cubit.dart';
import 'package:todo/views/all_home.dart';
import 'package:todo/views/finished_home.dart';
import 'package:todo/views/inprogress_home.dart';
import 'package:todo/views/waiting_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    context.read<GetTaskCubit>().getTasksList();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<GetTaskCubit>();
    return BlocBuilder<GetTaskCubit, GetTaskState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
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
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                      height: 5.h,
                    ),
                    const Text(
                      "My Tasks",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TabBar(
                  dividerHeight: 0,
                  tabs: [
                    Tab(
                      child: Text(
                        "All",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Inprogress",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Waiting",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Finished",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  controller: tabController,
                  indicatorColor: const Color(0XFF5f33e1),
                  indicatorWeight: 4,
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: ScrollPhysics(),
                    children: [
                      AllHome(),
                      InprogressHome(),
                      WaitingHome(),
                      FinishedHome(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0XFF5f33e1),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/add_task",
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
          ),
        );
      },
    );
  }
}
