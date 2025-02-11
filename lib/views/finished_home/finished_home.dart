import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/API/get_todos.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/views/finished_home/finished_home_views.dart';

class FinishedHome extends StatelessWidget {
  const FinishedHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTaskCubit, GetTaskState>(
      listener: (context, state) {
        if (state is BadRes) {
          toast(
            msg: "Token Expired.. please login again",
            color: Colors.red,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/login_screen",
            (route) => false,
          );
        } else {
          return;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is GetTaskLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFF5f33e1),
                      ),
                    )
                  : state is GetTaskSuccessState
                      ? state.getTodos
                              .where((task) =>
                                  task.status.toLowerCase() == 'finished')
                              .isEmpty
                          ? const Center(
                              child: Text("No Finished Tasks"),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: state.getTodos
                                    .where((task) =>
                                        task.status.toLowerCase() == 'finished')
                                    .length,
                                itemBuilder: (context, index) {
                                  return FinishedHomeViews(
                                    state: state.getTodos,
                                    index: index,
                                  );
                                },
                              ),
                            )
                      : const Center(
                          child: Text("Error"),
                        ),
            ],
          ),
        );
      },
    );
  }
}
