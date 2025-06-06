import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tasky/components/custom_button.dart';
import 'package:tasky/components/custom_text_form_field.dart';
import 'package:tasky/components/custom_toast.dart';
import 'package:tasky/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:tasky/cubits/get_task_cubit/get_task_cubit.dart';
import 'package:tasky/screens/propirty.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTaskCubit, CreateTaskState>(
      listener: (context, state) {
        final cubit = BlocProvider.of<CreateTaskCubit>(context);
        if (state is SuccessCreateTask) {
          context.read<GetTaskCubit>().getTasksList();
          Navigator.pop(context);
          cubit.titleCon.clear();
          cubit.descCon.clear();
          cubit.dateCon.clear();
          toast(
            msg: "Created",
            color: Colors.green,
          );
        } else if (state is LoadingCreateTask) {
          toast(msg: "Loading", color: Colors.green);
        } else if (state is ErrorCreateTask) {
          if (state.statusCode == 500) {
            toast(
              msg: "Please make sure to fill in all fields",
              color: Colors.red,
            );
          } else if (state.error == "Unauthorized") {
            toast(
              msg: "Token Expired.. please login again",
              color: Colors.red,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login_screen",
              (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<CreateTaskCubit>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                context.read<GetTaskCubit>().getTasksList();
                Navigator.pop(context);
                cubit.titleCon.clear();
                cubit.descCon.clear();
                cubit.dateCon.clear();
              },
              icon: Image.asset("assets/Arrow - Left00.png"),
            ),
            title: const Text(
              "Add new task",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: () async {
                  await cubit.pickImage();
                },
                child: Image.asset(
                  "assets/Frame 1111.png",
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text(
                  "Task title",
                ),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomTextFormField(
                controller: cubit.titleCon,
                hintText: "Enter title here",
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text(
                  "Task Description",
                ),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              CustomTextFormField(
                maxLines: 3,
                verticalSize: 8.5.h,
                controller: cubit.descCon,
                hintText: "Enter description here...",
              ),
              SizedBox(
                height: 1.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: const Text("Priority"),
              ),
              SizedBox(
                height: 1.4.h,
              ),
              PriorityButton(
                text: "medium",
                icon: Icons.flag_outlined,
                onSelected: (value) {
                  cubit.priority = value;
                },
                value1: 'medium',
                value2: 'high',
                value3: 'low',
              ),
              SizedBox(
                height: 1.4.h,
              ),
              SizedBox(
                height: 1.4.h,
              ),
              const SizedBox(
                height: 30,
              ),
              state is LoadingCreateTask
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0XFF5f33e1),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: CustomButton(
                        text: "Add task",
                        pressed: () async {
                          if (cubit.base64Image != null) {
                            cubit.createTask(
                              title: cubit.titleCon.text,
                              desc: cubit.descCon.text,
                              priority: (cubit.priority.isNotEmpty)
                                  ? cubit.priority
                                  : "medium",
                              dueDate:
                                  cubit.selectedDate?.toIso8601String() ?? "",
                              image: cubit.base64Image!,
                            );
                          } else {
                            toast(
                              msg: "Please select an image",
                              color: Colors.red,
                            );
                          }
                        },
                      ),
                    ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
