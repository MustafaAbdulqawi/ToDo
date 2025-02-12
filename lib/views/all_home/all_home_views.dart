import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/data/get_todos.dart';
import 'package:tasky/components/custom_clip_avatar.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';

class AllHomeViews extends StatelessWidget {
  const AllHomeViews({super.key, required this.state});
  final GetTodos state;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetTaskCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 1.7.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomClipAvatar(
            image: state.image,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      height: 4.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        color: cubit.getStatusColor(
                          state.status,
                        ),
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          state.status,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: cubit.getStatusTextColor(
                              state.status,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.7.h),
                Text(
                  state.description,
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
                        state.priority,
                      ),
                      size: 20.sp,
                    ),
                    SizedBox(width: 1.4.w),
                    Text(
                      state.priority,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: cubit.getPropirty(
                          state.priority,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 1.w),
                    Text(
                      state.createdAt.substring(0, 10),
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
                arguments: state,
              );
            },
            icon: const Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
    );
  }
}
