import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/components/custom_toast.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:tasky/views/all_home/all_home_views.dart';

class AllHome extends StatelessWidget {
  const AllHome({super.key,});

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
                  ? state.getTodos.isEmpty
                  ? const Center(
                child: Text("No Tasks"),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: state.getTodos.length,
                  itemBuilder: (context, index) {
                    return AllHomeViews(
                      state: state.getTodos[index],
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