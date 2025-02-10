import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/custom/custom_clip_avatar.dart';
import 'package:todo/screens/login_screen.dart';

class AllHome extends StatelessWidget {
  const AllHome({super.key});

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
        final cubit = context.read<GetTaskCubit>();
        return Padding(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is GetTaskLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
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
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.7.h,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomClipAvatar(
                                          image: state.getTodos[index].image,
                                        ),
                                        SizedBox(width: 2.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      state.getTodos[index]
                                                          .title,
                                                      style: TextStyle(
                                                        fontSize: 17.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 4.h,
                                                    width: 23.w,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          cubit.getStatusColor(
                                                        state.getTodos[index]
                                                            .status,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.getTodos[index]
                                                            .status,
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: cubit
                                                              .getStatusTextColor(
                                                            state
                                                                .getTodos[index]
                                                                .status,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 0.7.h),
                                              Text(
                                                state.getTodos[index]
                                                    .description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(height: 0.8.h),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.flag,
                                                    color: cubit.getPropirty(
                                                        state.getTodos[index]
                                                            .priority),
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(width: 1.4.w),
                                                  Text(
                                                    state.getTodos[index]
                                                        .priority,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: cubit.getPropirty(
                                                          state.getTodos[index]
                                                              .priority),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(width: 1.w),
                                                  Text(
                                                    state.getTodos[index]
                                                        .createdAt
                                                        .substring(0, 10),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              "/task_details",
                                              arguments: state.getTodos[index],
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.more_vert_sharp),
                                        ),
                                      ],
                                    ),
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
