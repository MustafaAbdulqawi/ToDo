import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo/API/get_todos.dart';
import 'package:todo/components/custom_date_details.dart';
import 'package:todo/components/custom_drop_down_button.dart';
import 'package:todo/components/custom_pop_menu_button_details.dart';
import 'package:todo/cubits/delete_task_cubit/delete_task_cubit.dart';
import 'package:todo/cubits/edit_task_cubit/edit_task_cubit.dart';
import 'package:todo/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:todo/screens/login_screen.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GetTodos data =
        ModalRoute.of(context)?.settings.arguments as GetTodos;
    return BlocBuilder<EditTaskCubit, EditTaskState>(
      builder: (context, state) {
        final cubit = context.read<EditTaskCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                context.read<GetTaskCubit>().getTasksList();
                Navigator.pop(context);
              },
              icon: Image.asset("assets/Arrow - Left00.png"),
            ),
            title: const Text(
              "Task Details",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            actions: [
              CustomPopMenuButtonDetails(
                pressed: () {
                  final cubit = context.read<EditTaskCubit>();
                  cubit.editing(data, context);
                },
                onTap: () {
                  final cubit = context.read<DeleteTaskCubit>();
                  cubit.deleteTask(data, context);
                },
                data: data,
              ),
            ],
          ),
          body: BlocConsumer<EditTaskCubit, EditTaskState>(
            listener: (context, state) {
              if (state is LoadingEdit) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(
                    child: CircularProgressIndicator(
                      color: Color(0XFF5f33e1),
                    ),
                  ),
                );
                // setState(() {});
              } else if (state is SuccessEdit) {
                toast(
                  msg: "Edit",
                  color: Colors.green,
                );
                Navigator.pop(context);
              } else {
                Text("Error");
              }
            },
            builder: (context, state) {
              return ListView(
                children: [
                  Image.memory(
                    base64Decode(
                      data.image,
                    ),
                    height: 300,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5.w),
                          child: Text(
                            textAlign: TextAlign.center,
                            data.description,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDateDetails(
                    dateText: data.createdAt.substring(0, 10),
                  ),
                  CustomDropDownButton(
                    // selected: cubit.selectedStatus ?? data.status,
                    selected: data.status,
                    onSelected: (value) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFF5f33e1),
                          ),
                        ),
                      );
                      cubit.updateStatus(value, data, context);
                    },
                    firstValue: "InProgress",
                    secondValue: "Waiting",
                    thirdValue: "Finished",
                  ),
                  CustomDropDownButton(
                    widget: Icon(
                      Icons.flag_outlined,
                      color: Color(0xFF5F33E1),
                    ),
                    selected: data.priority,
                    onSelected: (value) {
                      cubit.selectedPriority = value;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFF5f33e1),
                          ),
                        ),
                      );
                      cubit.updatePriority(value, data, context);
                    },
                    firstValue: "Heigh",
                    secondValue: "Medium",
                    thirdValue: "Low",
                  ),
                  // QR Code Widget
                  SizedBox(height: 2.h),
                  Center(
                    child: QrImageView(
                      data:
                          "ID is : ${data.id}Title is : ${data.title} \n Description is : ${data.description} \n Status is : ${data.status} \n Priority is : ${data.priority} \n Created At is : ${data.createdAt} \n Updated At is : ${data.updatedAt} \n User ID is : ${data.user}${data.user}",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

