import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/custom/custom_clip_avatar.dart';
import 'package:todo/screens/login_screen.dart';

class InprogressHome extends StatelessWidget {
  const InprogressHome({super.key});

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
                  ? state.getTodos
                  .where((task) =>
              task.status.toLowerCase() ==
                  'inprogress')
                  .isEmpty
                  ? const Center(
                child: Text("No Inprogress Tasks"),
              )
                  : Expanded(
                child: ListView.builder(
                  itemCount: state.getTodos
                      .where((task) =>
                  task.status
                      .toLowerCase() ==
                      'inprogress')
                      .length,
                  itemBuilder: (context, index) {
                    final filteredTodos = state
                        .getTodos
                        .where((task) =>
                    task.status
                        .toLowerCase() ==
                        'inprogress')
                        .toList();
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.7.h),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          CustomClipAvatar(
                            image: state.getTodos.where((task) => task.status.toLowerCase() == 'inprogress').toList()[index].image,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        filteredTodos[
                                        index]
                                            .title,
                                        style:
                                        TextStyle(
                                          fontSize:
                                          17.sp,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      height: 4.h,
                                      width: 23.w,
                                      decoration:
                                      BoxDecoration(
                                        color: cubit
                                            .getStatusColor(
                                          filteredTodos[
                                          index]
                                              .status,
                                        ),
                                        borderRadius:
                                        BorderRadius
                                            .circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          filteredTodos[
                                          index]
                                              .status,
                                          style:
                                          TextStyle(
                                            fontSize:
                                            16.sp,
                                            color: cubit
                                                .getStatusTextColor(
                                              filteredTodos[index]
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
                                SizedBox(
                                    height: 0.7.h),
                                Text(
                                  filteredTodos[
                                  index]
                                      .description,
                                  overflow:
                                  TextOverflow
                                      .ellipsis,
                                  maxLines: 1,
                                  style:
                                  const TextStyle(
                                    color: Colors
                                        .black54,
                                  ),
                                ),
                                SizedBox(
                                    height: 0.8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color: cubit
                                          .getPropirty(
                                        filteredTodos[
                                        index]
                                            .priority,
                                      ),
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                        width:
                                        1.4.w),
                                    Text(
                                      filteredTodos[
                                      index]
                                          .priority,
                                      style:
                                      TextStyle(
                                        fontSize:
                                        16.sp,
                                        color: cubit
                                            .getPropirty(
                                          filteredTodos[
                                          index]
                                              .priority,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                        width: 1.w),
                                    Text(
                                      filteredTodos[
                                      index]
                                          .createdAt
                                          .substring(
                                          0,
                                          10),
                                      style:
                                      const TextStyle(
                                        fontSize:
                                        14,
                                        color: Colors
                                            .black54,
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
                                arguments:
                                filteredTodos[
                                index],
                              );
                            },
                            icon: const Icon(Icons
                                .more_vert_sharp),
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
